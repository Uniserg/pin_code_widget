import 'package:flutter/material.dart';

class PointNotifier extends ChangeNotifier {
  bool _inflate = false;
  bool _filled = false;
  bool _joggle = false;
  int num = 0;

  Duration inflateDuration;
  Duration joggleDuration;

  PointNotifier(this.num,
      {this.inflateDuration = const Duration(milliseconds: 100),
      this.joggleDuration = const Duration(milliseconds: 100)});

  bool get filled => _filled;

  set filled(bool filled) {
    _filled = filled;
    notifyListeners();
  }

  bool get inflate => _inflate;
  bool get joggle => _joggle;

  void setInflate(bool inflate) {
    _inflate = inflate;
    notifyListeners();
  }

  void setJoggle(bool joggle) {
    _joggle = joggle;
    notifyListeners();
  }

  void runAnimation(void Function(bool animation) setter, Duration duration) {
    Future.delayed(duration).then((value) {
      setter(false);
    });
    setter(true);
  }

  void runInflateAnitmation() {
    runAnimation(setInflate, inflateDuration);
  }

  void runJoggleAnitmation() {
    runAnimation(setJoggle, joggleDuration);
  }
}
