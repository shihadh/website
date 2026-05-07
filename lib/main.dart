import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:provider/provider.dart';
import 'package:shihad_portfolio/core/theme/app_theme.dart';
import 'package:shihad_portfolio/portfolio/controller/portfolio_controller.dart';
import 'package:shihad_portfolio/portfolio/controller/hero_controller.dart'
    as hc;
import 'package:shihad_portfolio/demo/car_rental/controller/car_rental_provider.dart';
import 'package:shihad_portfolio/demo/finote/controller/finote_provider.dart';
import 'package:shihad_portfolio/portfolio/controller/skills_controller.dart';
import 'package:shihad_portfolio/demo/demo_provider.dart';
import 'package:shihad_portfolio/core/routing/app_router.dart';

void main() {
  usePathUrlStrategy();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PortfolioController()),
        ChangeNotifierProvider(create: (_) => hc.HeroController()),
        ChangeNotifierProvider(create: (_) => CarRentalProvider()),
        ChangeNotifierProvider(create: (_) => FinoteProvider()),
        ChangeNotifierProvider(create: (_) => DemoProvider()),
        ChangeNotifierProvider(create: (_) => SkillsController()),
      ],
      child: const PortfolioApp(),
    ),
  );
}

class PortfolioApp extends StatelessWidget {
  const PortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Shihad | Flutter Engineer',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      routerConfig: appRouter,
    );
  }
}
