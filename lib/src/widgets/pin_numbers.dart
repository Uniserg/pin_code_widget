import 'dart:math';

import 'package:flutter/material.dart';
import '../notifiers/pin_notifier.dart';
import '../styles/pin_number_style.dart';
import 'point_number.dart';

class PinNumbersWidget extends StatelessWidget {
  const PinNumbersWidget(
      {super.key,
      required this.pinLen,
      this.style = const PinNumbersStyle(),
      required this.pinNotifier});

  final PinNotifier pinNotifier;

  final int pinLen;

  final PinNumbersStyle style;

  Color getPinColor(BuildContext context) {
    return (pinNotifier.isAuth == null || pinNotifier.isAuth!)
        ? style.getPinPrimaryColor(context)
        : style.getPinFailedColor(context);
  }

  @override
  Widget build(BuildContext context) {
    double size = max(style.pinSize * style.pinInflateRatio,
        style.pinJoggleRatio * style.pinSpacing);

    return AnimatedBuilder(
      animation: pinNotifier,
      builder: (BuildContext context, Widget? child) {
        return SizedBox(
          height: size,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(pinNotifier.pinCap, (index) {
              var curPoint = pinNotifier.pointers[index];

              return PointNumber(
                  pointNotifier: curPoint,
                  style: style,
                  pinNotifier: pinNotifier);
            }),
          ),
        );
      },
    );
  }
}
