import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'point_notifier.dart';

class PinNotifier extends ChangeNotifier {
  int pinCap;
  int _pinLen = 0;
  final List<PointNotifier> _pin;
  bool isFilled = false;
  bool? _isAuth;

  PinNotifier(this.pinCap, {inflateDuration, joggleDuration})
      : _pin = List.generate(
            pinCap,
            (index) => PointNotifier(0,
                joggleDuration: joggleDuration,
                inflateDuration: inflateDuration));

  String get pin => _pin.take(_pinLen).map((e) => e.num).join();

  List<PointNotifier> get pointers => _pin;

  int get pinLen => _pinLen;

  set isAuth(auth) {
    _isAuth = auth;

    notifyListeners();

    if (_isAuth == null) return;

    if (!_isAuth!) {
      HapticFeedback.vibrate();
      for (var p in _pin) {
        p.runJoggleAnitmation();
      }
    } else {
      for (var p in _pin) {
        p.runInflateAnitmation();
      }
    }
  }

  bool? get isAuth => _isAuth;

  void addNum(int num) {
    if (_pinLen >= pinCap) return;

    var point = _pin[_pinLen];
    point.num = num;
    _pinLen++;

    if (_pinLen == pinCap) {
      isFilled = true;
    }

    point.filled = true;
    point.runInflateAnitmation();

    notifyListeners();
  }

  void clear() {
    isFilled = false;
    isAuth = null;
    _pinLen = 0;

    for (var point in _pin) {
      point.filled = false;
    }
  }

  void pop() {
    isFilled = false;
    if (_pinLen > 0) {
      _pin[_pinLen - 1].filled = false;
      _pinLen--;
    }
  }
}
