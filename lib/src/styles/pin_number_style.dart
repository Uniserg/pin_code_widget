import 'package:flutter/material.dart';

class PinNumbersStyle {
  final double pinSize;

  final double pinInflateRatio;

  final double pinJoggleRatio;

  final double pinSpacing;

  final Color? filledColor;

  final Color? failedPinColor;

  final Color? successColor;

  final Color? unfilledColor;

  const PinNumbersStyle({
    this.pinSize = 25,
    this.pinInflateRatio = 1.5,
    this.pinJoggleRatio = 1.5,
    this.pinSpacing = 20,
    this.filledColor,
    this.failedPinColor,
    this.successColor,
    this.unfilledColor = Colors.transparent,
  });

  Color getPinPrimaryColor(context) =>
      filledColor ?? Theme.of(context).primaryColor;

  Color getPinFailedColor(context) =>
      failedPinColor ?? Theme.of(context).colorScheme.error;

  Color getSuccesColor(context) => successColor ?? Theme.of(context).colorScheme.scrim;
}