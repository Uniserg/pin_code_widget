import 'package:flutter/material.dart';
import 'notifiers/pin_notifier.dart';
import 'styles/keyboard_style.dart';
import 'styles/pin_number_style.dart';
import 'widgets/keyboard.dart';
import 'widgets/pin_numbers.dart';

class PinCodeWidget extends StatefulWidget {
  const PinCodeWidget({
    super.key,
    required this.pinLen,
    required this.onAuth,
    this.keyboardStyle = const KeyboardStyle(),
    this.marginPincode = const EdgeInsets.only(bottom: 0),
    this.authButton,
    this.pinNumbersStyle = const PinNumbersStyle(),
    this.blockAtherAuthSuccess = false,
  });

  final KeyboardStyle keyboardStyle;

  final PinNumbersStyle pinNumbersStyle;

  final Widget? authButton;

  final Future<bool?> Function(String pin) onAuth;

  final int pinLen;

  final EdgeInsets marginPincode;

  final bool blockAtherAuthSuccess;

  @override
  State<StatefulWidget> createState() => PinCodeWidgetState();
}

class PinCodeWidgetState<T extends PinCodeWidget> extends State<T> {
  late PinNotifier pinNotifier = PinNotifier(widget.pinLen,
      joggleDuration: widget.pinNumbersStyle.joggleDuration,
      inflateDuration: widget.pinNumbersStyle.inflateDuration);

  @override
  void dispose() {
    for (var p in pinNotifier.pointers) {
      p.dispose();
    }

    pinNotifier.dispose();

    super.dispose();
  }

  void _onPressed(int num) async {
    pinNotifier.addNum(num);

    if (pinNotifier.isFilled) {
      var isAuth = await widget.onAuth(pinNotifier.pin);
      pinNotifier.isAuth = isAuth;

      if ((isAuth ?? false) && widget.blockAtherAuthSuccess) return;

      // Reset points after duration
      Future.delayed(widget.pinNumbersStyle.successDuration, () {
        pinNotifier.clear();
      });
    }
  }

  void _onRemove() {
    if (pinNotifier.pinLen == 0) {
      return;
    }
    pinNotifier.pop();
  }

  bool get isFailure => !(pinNotifier.isAuth == null || pinNotifier.isAuth!);

  get keyboard => KeyboardWidget(
        onPressed: _onPressed,
        keyboardStyle: widget.keyboardStyle,
        onDeletePressed: _onRemove,
        authButton: widget.authButton,
      );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: widget.marginPincode,
          child: PinNumbersWidget(
            pinLen: widget.pinLen,
            pinNotifier: pinNotifier,
            style: widget.pinNumbersStyle,
          ),
        ),
        AnimatedBuilder(
          animation: pinNotifier,
          builder: (BuildContext context, Widget? child) => AbsorbPointer(
            absorbing: pinNotifier.isFilled,
            child: keyboard,
          ),
        ),
      ],
    );
  }
}
