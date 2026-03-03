import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shihad_portfolio/core/theme/app_theme.dart';
import 'package:shihad_portfolio/demo/demo_provider.dart';
import 'package:shihad_portfolio/core/widgets/phone_frame.dart';
import 'package:shihad_portfolio/demo/car_rental/view/intro_screen.dart';
import 'package:shihad_portfolio/demo/car_rental/view/login_screen.dart';
import 'package:shihad_portfolio/demo/car_rental/view/home_screen.dart';
import 'package:shihad_portfolio/demo/car_rental/view/details_screen.dart';
import 'package:shihad_portfolio/demo/car_rental/controller/car_rental_provider.dart';
import 'package:shihad_portfolio/demo/finote/controller/finote_provider.dart';
import 'package:shihad_portfolio/demo/finote/view/finote_home.dart';
import 'package:shihad_portfolio/demo/finote/view/finote_history.dart';
import 'package:shihad_portfolio/demo/finote/view/finote_add_transaction.dart';
import 'package:shihad_portfolio/demo/finote/view/finote_ai_assistant.dart';
import 'package:shihad_portfolio/core/constants/text_constants.dart';

class PhoneModal extends StatelessWidget {
  const PhoneModal({super.key});

  @override
  Widget build(BuildContext context) {
    final demoProvider = context.watch<DemoProvider>();
    final carRentalProvider = context.watch<CarRentalProvider>();
    final finoteProvider = context.watch<FinoteProvider>();

    if (!demoProvider.isModalOpen && demoProvider.activeDemo == DemoType.none) {
      return const SizedBox.shrink();
    }

    return AnimatedOpacity(
      duration: const Duration(milliseconds: 300),
      opacity: demoProvider.isModalOpen ? 1.0 : 0.0,
      child: Stack(
        children: [
          // Background Dim
          GestureDetector(
            onTap: () => demoProvider.closeDemo(),
            child: Container(color: Colors.black.withValues(alpha: 0.8)),
          ),

          // 3D Phone Modal
          Center(
            child: TweenAnimationBuilder<double>(
              tween: Tween(
                begin: 0.0,
                end: demoProvider.isModalOpen ? 1.0 : 0.0,
              ),
              duration: const Duration(milliseconds: 600),
              curve: Curves.easeOutCubic,
              builder: (context, value, child) {
                return Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.identity()
                    ..scaleByDouble(value, value, 1.0, 1.0)
                    ..setEntry(3, 2, 0.001)
                    ..scale(0.7 + (0.3 * value))
                    ..rotateY(0.4 * (1 - value)),
                  child: PhoneFrame(
                    screen: _buildDemoScreen(
                      demoProvider,
                      carRentalProvider,
                      finoteProvider,
                    ),
                  ),
                );
              },
            ),
          ),

          // Close Button
          Positioned(
            top: 40,
            right: 40,
            child: IconButton(
              icon: const Icon(Icons.close, color: AppTheme.primary, size: 32),
              onPressed: () => demoProvider.closeDemo(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDemoScreen(
    DemoProvider provider,
    CarRentalProvider carRentalProvider,
    FinoteProvider finoteProvider,
  ) {
    switch (provider.activeDemo) {
      case DemoType.finote:
        return _buildFinoteFlow(finoteProvider);
      case DemoType.carRental:
        return _buildCarRentalFlow(carRentalProvider.carRentalScreenIndex);
      case DemoType.gameVerse:
        return const _PlaceholderDemo(title: AppText.gameVerseTitle);
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _buildCarRentalFlow(int index) {
    switch (index) {
      case 0:
        return const CarIntroScreen();
      case 1:
        return const CarLoginScreen();
      case 2:
        return const CarHomeScreen();
      case 3:
        return const CarDetailsScreen();
      default:
        return const CarIntroScreen();
    }
  }

  Widget _buildFinoteFlow(FinoteProvider provider) {
    if (provider.showAiAssistant) {
      return const FinoteAiAssistantScreen();
    }

    return Scaffold(
      body: IndexedStack(
        index: provider.bottomNavIndex,
        children: const [
          FinoteHomeScreen(),
          FinoteAddTransactionScreen(),
          FinoteHistoryScreen(),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: provider.bottomNavIndex,
          onTap: (index) => provider.setBottomNavIndex(index),
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.black54,
          selectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
          unselectedLabelStyle: const TextStyle(fontSize: 12),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              activeIcon: Icon(Icons.home),
              label: AppText.navHome,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add_outlined),
              activeIcon: Icon(Icons.add),
              label: AppText.navTransactions,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.receipt_long_outlined),
              activeIcon: Icon(Icons.receipt_long),
              label: AppText.navHistory,
            ),
          ],
        ),
      ),
    );
  }
}

class _PlaceholderDemo extends StatelessWidget {
  final String title;
  const _PlaceholderDemo({required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.background,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.construction, size: 64, color: AppTheme.secondary),
            const SizedBox(height: 16),
            Text(title, style: const TextStyle(color: AppTheme.secondary)),
          ],
        ),
      ),
    );
  }
}
