import 'package:flutter/material.dart';
import 'package:shihad_portfolio/core/constants/asset_constants.dart';

class CarRentalProvider extends ChangeNotifier {
  // Car Rental Demo State
  int _carRentalScreenIndex = 0;
  int get carRentalScreenIndex => _carRentalScreenIndex;

  bool _isLoggedIn = false;
  bool get isLoggedIn => _isLoggedIn;

  void nextCarRentalScreen() {
    _carRentalScreenIndex++;
    notifyListeners();
  }

  void resetCarRental() {
    _carRentalScreenIndex = 0;
    _isLoggedIn = false;
    notifyListeners();
  }

  void login() {
    _isLoggedIn = true;
    _carRentalScreenIndex = 2; // Navigate to Home after login
    notifyListeners();
  }

  // Car Rental Mock Data
  final List<Map<String, dynamic>> cars = [
    {
      'name': 'Maruthi Alto',
      'type': 'Premium Hatchback',
      'price': 450.0,
      'rating': 4.9,
      'reviews': 245,
      'image': AppAssets.car1_1,
      'additionalImages': [AppAssets.car1_1, AppAssets.car1_2],
      'specs': {
        'seats': '4 Seats',
        'hp': '48 Hp',
        'speed': '140 km/h',
        'transmission': 'Manual',
      },
    },
    {
      'name': 'Lamborghini',
      'type': 'Supercar',
      'price': 1200.0,
      'rating': 5.0,
      'reviews': 120,
      'image': AppAssets.car2_1,
      'additionalImages': [AppAssets.car2_1, AppAssets.car2_2],
      'specs': {
        'seats': '2 Seats',
        'hp': '610 Hp',
        'speed': '325 km/h',
        'transmission': 'Auto',
      },
    },
  ];

  Map<String, dynamic>? _selectedCar;
  Map<String, dynamic>? get selectedCar => _selectedCar;

  int _currentCarouselIndex = 0;
  int get currentCarouselIndex => _currentCarouselIndex;

  void onCarouselPageChanged(int index) {
    _currentCarouselIndex = index;
    notifyListeners();
  }

  void selectCar(Map<String, dynamic> car) {
    _selectedCar = car;
    _currentCarouselIndex = 0; // Reset carousel index
    _carRentalScreenIndex = 3; // Navigate to Details
    notifyListeners();
  }
}
