import 'package:flutter/material.dart';

class FinoteProvider extends ChangeNotifier {
  int _bottomNavIndex = 0;
  int get bottomNavIndex => _bottomNavIndex;

  bool _isLoggedIn = false;
  bool get isLoggedIn => _isLoggedIn;

  bool _showAiAssistant = false;
  bool get showAiAssistant => _showAiAssistant;

  void setLoggedIn(bool value) {
    _isLoggedIn = value;
    notifyListeners();
  }

  void setShowAiAssistant(bool value) {
    _showAiAssistant = value;
    notifyListeners();
  }

  void setBottomNavIndex(int index) {
    _bottomNavIndex = index;
    notifyListeners();
  }

  // Adapted Finote Data
  final Map<String, dynamic> finoteData = {
    'balance': 12450,
    'spending_analysis': 'AI Insight: You spent 20% more on dining this week.',
    'transactions': [
      {
        'title': 'Groceries',
        'amount': -50,
        'category': 'Food',
        'date': 'Today',
      },
      {
        'title': 'Salary',
        'amount': 3000,
        'category': 'Income',
        'date': 'Yesterday',
      },
      {
        'title': 'Amazon',
        'amount': -120.0,
        'category': 'Shopping',
        'date': '2 days ago',
      },
    ],
  };

  void addTransaction(Map<String, dynamic> transaction) {
    (finoteData['transactions'] as List).insert(0, transaction);
    if (transaction['amount'] != null) {
      finoteData['balance'] += transaction['amount'];
    }
    notifyListeners();
  }
}
