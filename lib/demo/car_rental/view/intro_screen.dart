import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shihad_portfolio/demo/car_rental/controller/car_rental_provider.dart';
import 'package:shihad_portfolio/core/constants/text_constants.dart';

class CarIntroScreen extends StatelessWidget {
  const CarIntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0E0E0E),
      body: Stack(
        children: [
          Positioned(
            top: 100,
            left: 0,
            right: 0,
            child: Image.asset(
              'assets/images/intro.webp', // Using Huracan for intro
              width: double.infinity,
              fit: BoxFit.contain,
            ),
          ),
          Positioned(
            bottom: 60,
            left: 30,
            right: 30,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  AppText.carIntroTitle,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  AppText.carIntroSubtitle,
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
                const SizedBox(height: 40),
                SizedBox(
                  width: double.infinity,
                  height: 40,
                  child: ElevatedButton(
                    onPressed: () =>
                        context.read<CarRentalProvider>().nextCarRentalScreen(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: const Text(
                      AppText.carIntroBtn,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
