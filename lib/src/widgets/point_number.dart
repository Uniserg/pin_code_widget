import 'dart:math';

import 'package:flutter/material.dart';
import '../notifiers/point_notifier.dart';
import '../styles/pin_number_style.dart';
import '../notifiers/pin_notifier.dart';

class PointNumber extends StatefulWidget {
  final PointNotifier pointNotifier;
  final PinNumbersStyle style;
  final PinNotifier pinNotifier;

  const PointNumber(
      {super.key,
      required this.pointNotifier,
      required this.style,
      required this.pinNotifier});

  @override
  State<PointNumber> createState() => _PointNumberState();
}

class _PointNumberState extends State<PointNumber>
    with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: widget.style.joggleDuration,
    );

    animation = Tween(
            begin: 0.0,
            end: widget.style.pinSpacing / 2 * widget.style.pinJoggleRatio)
        .chain(CurveTween(curve: Curves.elasticIn))
        .animate(controller)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          controller.reverse();
        }
      });

    animation.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final style = widget.style;
    final pointNotifier = widget.pointNotifier;
    final pinNotifier = widget.pinNotifier;

    if (widget.pointNotifier.joggle) {
      controller.forward();
    }

    Color getPinColor(BuildContext context) {
      final isAuth = pinNotifier.isAuth;

      if (isAuth == null) return style.getPinPrimaryColor(context);
      if (!isAuth) return style.getPinFailedColor(context);

      return style.getSuccesColor(context);
    }

    double size = max(style.pinSize * style.pinInflateRatio,
        style.pinSize + style.pinJoggleRatio * style.pinSpacing);

    return AnimatedBuilder(
        animation: pointNotifier,
        builder: (BuildContext context, Widget? child) {
          return SizedBox(
            width: size,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                  left: -animation.value,
                  right: animation.value,
                  child: AnimatedContainer(
                    width: !pointNotifier.inflate
                        ? style.pinSize
                        : style.pinSize * style.pinInflateRatio,
                    height: !pointNotifier.inflate
                        ? style.pinSize
                        : style.pinSize * style.pinInflateRatio,
                    duration: style.inflateDuration,
                    curve: Curves.easeInOut,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: pointNotifier.filled
                          ? getPinColor(context)
                          : style.unfilledColor,
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
}
