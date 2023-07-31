import 'package:flutter/material.dart';
import 'package:pin_code_widget/pin_code_widget.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

enum HintType { failure, repeat, none }

class InfoHintNotifier extends ChangeNotifier {
  HintType _hint = HintType.none;

  set currentHint(HintType hint) {
    _hint = hint;
    notifyListeners();
  }

  HintType get currentHint => _hint;
}

class _MainAppState extends State<MainApp> {
  String? enteredPin;

  late InfoHintNotifier hintNotifier;

  @override
  void initState() {
    hintNotifier = InfoHintNotifier();
    super.initState();
  }

  @override
  void dispose() {
    hintNotifier.dispose();
    super.dispose();
  }

  Future<bool?> onAuth(String pin) async {
    if (enteredPin == null) {
      enteredPin = pin;
      hintNotifier.currentHint = HintType.repeat;

      Future.delayed(const Duration(seconds: 1),
          () => hintNotifier.currentHint = HintType.none);
      return null;
    }

    final isAuthSuccess = pin == enteredPin;

    if (isAuthSuccess) {
      hintNotifier.currentHint = HintType.none;
    } else {
      hintNotifier.currentHint = HintType.failure;

      Future.delayed(const Duration(seconds: 1),
          () => hintNotifier.currentHint = HintType.none);
    }
    return isAuthSuccess;
  }

  get failureHint => const Padding(
        padding: EdgeInsets.all(8.0),
        child: Text(
          "Invalid PIN-code! Try again.",
          style: TextStyle(color: Colors.red, fontSize: 18),
        ),
      );

  get repeatHint => const Padding(
        padding: EdgeInsets.all(8.0),
        child: Text(
          "Enter Pin-code againt to save",
          style: TextStyle(color: Colors.blue, fontSize: 18),
        ),
      );

  get customPinCodeWidget => PinCodeWidget(
        pinLen: 4,
        onAuth: onAuth,
        keyboardStyle: const KeyboardStyle(
            width: 350,
            deleteIcon: Icon(
              Icons.backspace_rounded,
              size: 32,
            )),
        pinNumbersStyle:
            PinNumbersStyle(unfilledColor: Colors.blue.withOpacity(0.5)),
        authButton: IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.fingerprint,
            color: Colors.blue,
            size: 60,
          ),
        ),
      );

  get hint => AnimatedBuilder(
        animation: hintNotifier,
        builder: (BuildContext context, Widget? child) => Visibility(
          maintainSize: true,
          maintainAnimation: true,
          maintainState: true,
          visible: hintNotifier.currentHint != HintType.none,
          child: hintNotifier.currentHint == HintType.repeat
              ? repeatHint
              : failureHint,
        ),
      );

  get title => Center(
        child: Text(
          "Enter the PIN-code",
          style: TextStyle(fontSize: 24, color: Theme.of(context).primaryColor),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          margin: const EdgeInsets.only(top: 50),
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  title,
                  hint,
                  const SizedBox(height: 10),
                  Center(
                      child: Container(
                    alignment: Alignment.center,
                    child: customPinCodeWidget,
                  )),
                  Center(
                    child: TextButton(
                      onPressed: () {},
                      child: const Text(
                        "Forgot?",
                        style: TextStyle(fontSize: 24),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
