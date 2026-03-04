import 'package:flutter/material.dart';

class HeroController extends ChangeNotifier {
  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  double _scrollProgress = 0.0;
  double get scrollProgress => _scrollProgress;

  Offset _mousePosition = Offset.zero;
  Offset get mousePosition => _mousePosition;

  void triggerLoad() {
    _isLoaded = true;
    notifyListeners();
  }

  void updateScroll(double value) {
    if (_scrollProgress != value) {
      _scrollProgress = value;
      notifyListeners();
    }
  }

  void updateMousePosition(Offset offset) {
    if (_mousePosition != offset) {
      _mousePosition = offset;
      notifyListeners();
    }
  }
}
