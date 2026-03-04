import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shihad_portfolio/portfolio/controller/portfolio_controller.dart';
import 'package:shihad_portfolio/portfolio/controller/hero_controller.dart'
    as hc;
import 'package:shihad_portfolio/portfolio/view/hero_section.dart';
import 'package:shihad_portfolio/portfolio/view/skills_section.dart';
import 'package:shihad_portfolio/portfolio/view/contact_section.dart';
import 'package:shihad_portfolio/portfolio/controller/skills_controller.dart';
import 'package:shihad_portfolio/showcase/showcase_section.dart';
import 'package:shihad_portfolio/core/widgets/phone_modal.dart';
import 'package:shihad_portfolio/core/theme/app_theme.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final portfolioController = context.read<PortfolioController>();

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

              // Check visibility for Skills Section
              if (portfolioController.skillsKey.currentContext != null) {
                final renderBox =
                    portfolioController.skillsKey.currentContext!
                            .findRenderObject()
                        as RenderBox?;
                if (renderBox != null) {
                  final position = renderBox.localToGlobal(Offset.zero);
                  final screenHeight = MediaQuery.of(context).size.height;
                  // Trigger when the section top is 70% from the top of the screen
                  if (position.dy < screenHeight * 0.7) {
                    context.read<SkillsController>().triggerVisibility();
                  }
                }
              }
              return false; // Let it bubble up
            },
            child: SingleChildScrollView(
              controller: portfolioController.scrollController,
              child: Column(
                children: [
                  const HeroSection(),
                  SkillsSection(key: portfolioController.skillsKey),
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
