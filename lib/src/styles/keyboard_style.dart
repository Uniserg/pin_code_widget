import 'package:flutter/material.dart';

class KeyboardStyle {
  final Color? deleteButtonColor;
  final Color? onPressColorAnimation;
  final Color? buttonColor;
  final Icon deleteIcon;
  final TextStyle? numberStyle;
  final BorderSide? borderSide;
  final double width;
  final double height;
  final double horizontalSpacing;
  final double verticalSpacing;

  const KeyboardStyle(
      {this.width = 400,
      this.height = 480,
      this.horizontalSpacing = 20,
      this.verticalSpacing = 20,
      this.deleteButtonColor,
      this.onPressColorAnimation,
      this.buttonColor,
      this.deleteIcon = const Icon(Icons.backspace_outlined),
      this.numberStyle,
      this.borderSide});

  Color getButtonColor(BuildContext context) =>
      buttonColor ?? Theme.of(context).primaryColor;
  Color getDeleteButtonColor(BuildContext context) =>
      deleteButtonColor ?? Theme.of(context).colorScheme.error;
  Color getOnPressColorAnimation(BuildContext context) =>
      onPressColorAnimation ?? Theme.of(context).primaryColorLight;
  BorderSide getBorderSide(BuildContext context) =>
      borderSide ??
      BorderSide(color: Theme.of(context).colorScheme.onPrimary, width: 2);
  TextStyle? getNumberStyle(BuildContext context) =>
      numberStyle ?? Theme.of(context).primaryTextTheme.displayMedium;
}
