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

  set isAuth(bool? auth) {
    _isAuth = auth;

    notifyListeners();

    if (_isAuth == null || _isAuth == true) {
      for (var p in _pin) {
        p.runInflateAnitmation();
      }
    } else {
      HapticFeedback.vibrate();
      for (var p in _pin) {
        p.runJoggleAnitmation();
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
  }

  void clear() {
    isFilled = false;
    _isAuth = null;
    _pinLen = 0;

    for (var point in _pin) {
      point.filled = false;
    }
    notifyListeners();
  }

  void pop() {
    isFilled = false;
    if (_pinLen > 0) {
      _pin[_pinLen - 1].filled = false;
      _pinLen--;
    }
  }
}
