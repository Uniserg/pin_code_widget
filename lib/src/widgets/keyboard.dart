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

  ElevatedButton getButton(BuildContext context, Color color,
      void Function()? onPressed, Widget child) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: keyboardStyle.getOnPressColorAnimation(context),
        side: keyboardStyle.getBorderSide(context),
        shape: const CircleBorder(),
      ),
      onPressed: onPressed,
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {

    return Center(
      child: Container(
        padding: const EdgeInsets.all(8.0),
        alignment: Alignment.center,
        // width: keyboardStyle.width,
        width: keyboardStyle.width,
        // TODO: УБРАТЬ HEIGHT
        // height: keyboardStyle.height,
        
        child: GridView.count(
          shrinkWrap: true,
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
                  child: getButton(
                      context,
                      keyboardStyle.getDeleteButtonColor(context),
                      onDeletePressed,
                      keyboardStyle.deleteIcon),
                );
              } else if (index == 10) {
                index = 0;
              } else {
                index++;
              }

              return getButton(
                  context,
                  keyboardStyle.getButtonColor(context),
                  () => onPressed!(index),
                  Text('$index', style: keyboardStyle.getNumberStyle(context)));
            },
          ),
        ),
      ),
    );
  }
}
