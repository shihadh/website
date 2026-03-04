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

  // Transaction Form State
  final TextEditingController amountController = TextEditingController();
  final TextEditingController noteController = TextEditingController();
  String _selectedCategory = 'Select category';
  String get selectedCategory => _selectedCategory;
  bool _isIncome = true;
  bool get isIncome => _isIncome;

  void setCategory(String category) {
    _selectedCategory = category;
    notifyListeners();
  }

  void setIncome(bool value) {
    _isIncome = value;
    notifyListeners();
  }

  void clearForm() {
    amountController.clear();
    noteController.clear();
    _selectedCategory = 'Select category';
    _isIncome = true;
    notifyListeners();
  }

  @override
  void dispose() {
    amountController.dispose();
    noteController.dispose();
    super.dispose();
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
