import 'package:flutter/material.dart';

import '../styles/keyboard_style.dart';

class KeyboardWidget extends StatelessWidget {
  const KeyboardWidget(
      {super.key,
      this.keyboardStyle = const KeyboardStyle(),
      this.onPressed,
      this.onDeletePressed,
      this.authButton});

  final KeyboardStyle keyboardStyle;
  final Function()? onDeletePressed;
  final Function(int)? onPressed;

  final Widget? authButton;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(8.0),
        alignment: Alignment.center,
        width: keyboardStyle.width,
        height: keyboardStyle.height,
        child: GridView.count(
          crossAxisCount: 3,
          mainAxisSpacing: keyboardStyle.verticalSpacing,
          crossAxisSpacing: keyboardStyle.horizontalSpacing,
          physics: const NeverScrollableScrollPhysics(),
          children: List.generate(
            12,
            (index) {
              if (index == 9) return authButton ?? Container();
              if (index == 11) {
                return MergeSemantics(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          keyboardStyle.getDeleteButtonColor(context),
                      foregroundColor:
                          keyboardStyle.getOnPressColorAnimation(context),
                      side: keyboardStyle.getBorderSide(context),
                      shape: const CircleBorder(),
                    ),
                    onPressed: onDeletePressed,
                    child: keyboardStyle.deleteIcon,
                  ),
                );
              } else if (index == 10) {
                index = 0;
              } else {
                index++;
              }
              return ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: keyboardStyle.getButtonColor(context),
                  foregroundColor:
                      keyboardStyle.getOnPressColorAnimation(context),
                  side: keyboardStyle.getBorderSide(context),
                  shape: const CircleBorder(),
                ),
                onPressed: () => onPressed!(index),
                child: Text('$index',
                    style: keyboardStyle.getNumberStyle(context)),
              );
            },
          ),
        ),
      ),
    );
  }
}
