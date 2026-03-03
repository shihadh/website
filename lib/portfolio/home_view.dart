import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shihad_portfolio/portfolio/portfolio_controller.dart';
import 'package:shihad_portfolio/portfolio/hero_controller.dart' as hc;
import 'package:shihad_portfolio/portfolio/hero_section.dart';
import 'package:shihad_portfolio/portfolio/contact_section.dart';
import 'package:shihad_portfolio/showcase/showcase_section.dart';
import 'package:shihad_portfolio/core/widgets/phone_modal.dart';
import 'package:shihad_portfolio/core/theme/app_theme.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final portfolioController = context.watch<PortfolioController>();

    return Scaffold(
      backgroundColor: AppTheme.background,
      body: Stack(
        children: [
          NotificationListener<ScrollNotification>(
            onNotification: (scrollInfo) {
              // Calculate scroll progress for the first 800 pixels
              double progress = (scrollInfo.metrics.pixels / 800).clamp(
                0.0,
                1.0,
              );
              // We use read to avoid rebuilding HomeView
              context.read<hc.HeroController>().updateScroll(progress);
              return false; // Let it bubble up
            },
            child: SingleChildScrollView(
              controller: portfolioController.scrollController,
              child: Column(
                children: [
                  const HeroSection(),
                  ShowcaseSection(key: portfolioController.showcaseKey),
                  ContactSection(key: portfolioController.contactKey),
                ],
              ),
            ),
          ),
          const PhoneModal(),
        ],
      ),
    );
  }
}
