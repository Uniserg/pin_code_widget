import 'package:flutter/material.dart';

class PinNumbersStyle {
  final double pinSize;

  final double pinInflateRatio;

  final double pinJoggleRatio;

  final double pinSpacing;

  final Color? filledPinColor;

  final Color? failedPinColor;

  final Color? unfilledPinColor;

  const PinNumbersStyle({
    this.pinSize = 25,
    this.pinInflateRatio = 1.5,
    this.pinJoggleRatio = 1.5,
    this.pinSpacing = 20,
    this.filledPinColor,
    this.failedPinColor,
    this.unfilledPinColor = Colors.transparent,
  });

  Color getPinPrimaryColor(context) =>
      filledPinColor ?? Theme.of(context).primaryColor;

  Color getPinFailedColor(context) =>
      failedPinColor ?? Theme.of(context).colorScheme.error;
}