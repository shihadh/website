import 'package:flutter/material.dart';

enum DemoType { finote, carRental, gameVerse, none }

class DemoProvider extends ChangeNotifier {
  DemoType _activeDemo = DemoType.none;
  DemoType get activeDemo => _activeDemo;

  bool _isModalOpen = false;
  bool get isModalOpen => _isModalOpen;

  void openDemo(DemoType type) {
    _activeDemo = type;
    _isModalOpen = true;
    notifyListeners();
  }

  void closeDemo() {
    _isModalOpen = false;
    // Delay resetting the type to allow for closing animations
    Future.delayed(const Duration(milliseconds: 600), () {
      _activeDemo = DemoType.none;
      notifyListeners();
    });
    notifyListeners();
  }
}
