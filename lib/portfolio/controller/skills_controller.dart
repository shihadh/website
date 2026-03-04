import 'dart:async';
import 'package:flutter/material.dart';

class SkillsController extends ChangeNotifier {
  bool _isVisible = false;
  bool get isVisible => _isVisible;

  String? _openedAppId;
  String? get openedAppId => _openedAppId;

  late Timer _timer;
  DateTime _currentTime = DateTime.now();

  SkillsController() {
    _startTimer();
  }

  String get formattedTime {
    int hour = _currentTime.hour;
    hour = hour % 12;
    if (hour == 0) hour = 12;
    final hourStr = hour.toString();
    final minuteStr = _currentTime.minute.toString().padLeft(2, '0');
    return '$hourStr:$minuteStr';
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      final now = DateTime.now();
      if (now.minute != _currentTime.minute) {
        _currentTime = now;
        notifyListeners();
      }
    });
  }

  void triggerVisibility() {
    if (!_isVisible) {
      _isVisible = true;
      notifyListeners();
    }
  }

  void openApp(String? appId) {
    if (_openedAppId != appId) {
      _openedAppId = appId;
      notifyListeners();
    }
  }

  void closeApp() {
    if (_openedAppId != null) {
      _openedAppId = null;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}
