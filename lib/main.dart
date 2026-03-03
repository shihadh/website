import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shihad_portfolio/core/theme/app_theme.dart';
import 'package:shihad_portfolio/portfolio/portfolio_controller.dart';
import 'package:shihad_portfolio/portfolio/hero_controller.dart' as hc;
import 'package:shihad_portfolio/demo/car_rental/controller/car_rental_provider.dart';
import 'package:shihad_portfolio/demo/finote/controller/finote_provider.dart';
import 'package:shihad_portfolio/portfolio/home_view.dart';
import 'package:shihad_portfolio/demo/demo_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PortfolioController()),
        ChangeNotifierProvider(create: (_) => hc.HeroController()),
        ChangeNotifierProvider(create: (_) => CarRentalProvider()),
        ChangeNotifierProvider(create: (_) => FinoteProvider()),
        ChangeNotifierProvider(create: (_) => DemoProvider()),
      ],
      child: const PortfolioApp(),
    ),
  );
}

class PortfolioApp extends StatelessWidget {
  const PortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shihad | Flutter Engineer',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      home: const HomeView(),
    );
  }
}
