import 'package:flutter/material.dart';
import 'package:pin_code_widget/pin_code_widget.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  get newPin => PinCodeWidget(
        onFilledPin: (String pin) {},
        onAuth: (pin) async => pin == "1234",
        onFailureHint: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            "Invalid PIN-code! Try again.",
            style: TextStyle(color: Colors.red, fontSize: 18),
          ),
        ),
        pinLen: 4,
        keyboardStyle: const KeyboardStyle(
            width: 350,
            deleteIcon: Icon(
              Icons.backspace_rounded,
              size: 32,
            )),
        pinNumbersStyle: PinNumbersStyle(unfilledColor: Colors.blue.withOpacity(0.5)),
        authButton: IconButton(
          // iconSize: 60,
          // заменить
          // style: ElevatedButton.styleFrom(
          //     shape: const CircleBorder(),
          //     side: BorderSide(
          //         color: Theme.of(context).colorScheme.onPrimary, width: 2)),
          onPressed: () {},
          icon: const Icon(
            Icons.fingerprint,
            color: Colors.blue,
            size: 60,
          ),
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
                  Center(
                    child: Text(
                      "Enter the PIN-code",
                      style: TextStyle(
                          fontSize: 24, color: Theme.of(context).primaryColor),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Center(
                      child: Container(
                          alignment: Alignment.center, child: newPin)),
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
