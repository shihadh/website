import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shihad_portfolio/core/responsive.dart';
import 'package:shihad_portfolio/portfolio/controller/hero_controller.dart'
    as hc;
import 'package:shihad_portfolio/core/theme/app_theme.dart';
import 'package:shihad_portfolio/core/widgets/phone_frame.dart';
import 'package:shihad_portfolio/core/constants/text_constants.dart';

class HeroSection extends StatefulWidget {
  const HeroSection({super.key});

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<hc.HeroController>().triggerLoad();
    });
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveLayout.isMobile(context);
    return Container(
      height: isMobile ? 650 : 800,
      width: double.infinity,
      color: AppTheme.background,
      child: Stack(
        children: [
          // Radial Glow Background
          const Positioned.fill(child: _RadialBackgroundGlow()),

          // Massive Background Text: FLUTTER ENGINEER
          const Positioned.fill(
            child: RepaintBoundary(child: _BackgroundText()),
          ),

          // Centerpiece: PhoneFrame (Floating)
          const Center(child: _PhoneCenterpiece()),

          // Typography Overlays: Split Layout
          Positioned(
            left: 0,
            right: 0,
            top: isMobile ? 40 : 80,
            child: const RepaintBoundary(child: _TypographyOverlay()),
          ),

          // Sidebar Info: Bottom Left Area
          Positioned(
            bottom: isMobile ? 20 : 90,
            left: isMobile ? 20 : 80,
            child: const RepaintBoundary(
              child: _SideInfoCard(
                title: AppText.sideCardPreOrdersTitle,
                description: AppText.sideCardPreOrdersDesc,
              ),
            ),
          ),

          // Sidebar Info: Bottom Right Area
          Positioned(
            bottom: isMobile ? 20 : 90,
            right: isMobile ? 20 : 80,
            child: const RepaintBoundary(
              child: _SideInfoCard(
                title: AppText.sideCardExclusiveTitle,
                description: AppText.sideCardExclusiveDesc,
                isProjectLink: true,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _RadialBackgroundGlow extends StatelessWidget {
  const _RadialBackgroundGlow();

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            center: const Alignment(0, 0),
            radius: 0.8,
            colors: [
              AppTheme.accent.withValues(alpha: 0.06),
              Colors.transparent,
            ],
          ),
        ),
      ),
    );
  }
}

class _BackgroundText extends StatelessWidget {
  const _BackgroundText();

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveLayout.isMobile(context);
    final textStyle = GoogleFonts.bebasNeue(
      fontSize: isMobile ? 140 : 260,
      fontWeight: FontWeight.w900,
      letterSpacing: isMobile ? 4 : 2,
      color: Colors.white,
      height: 0.8,
    );

    return Selector<hc.HeroController, bool>(
      selector: (context, controller) => controller.isLoaded,
      builder: (context, isLoaded, child) {
        return Stack(
          alignment: Alignment.center,
          children: [
            // "FLUTTER" - Sliding from Left
            AnimatedPositioned(
              duration: const Duration(milliseconds: 2000),
              curve: Curves.easeOutExpo,
              left: isLoaded ? 0 : -400,
              right: isLoaded ? 0 : 400,
              top: isMobile ? 180 : 200,
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 1500),
                opacity: isLoaded ? 0.04 : 0.0,
                child: Text(
                  "FLUTTER",
                  textAlign: TextAlign.center,
                  style: textStyle,
                ),
              ),
            ),
            // "ENGINEER" - Sliding from Right
            AnimatedPositioned(
              duration: const Duration(milliseconds: 2000),
              curve: Curves.easeOutExpo,
              left: isLoaded ? 0 : 400,
              right: isLoaded ? 0 : -400,
              bottom: isMobile ? 180 : 200,
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 1500),
                opacity: isLoaded ? 0.04 : 0.0,
                child: Text(
                  "ENGINEER",
                  textAlign: TextAlign.center,
                  style: textStyle,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _TypographyOverlay extends StatelessWidget {
  const _TypographyOverlay();

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveLayout.isMobile(context);

    // Cache styles outside of Selector
    final titleStyle = GoogleFonts.kaushanScript(
      color: AppTheme.accent,
      fontSize: isMobile ? 60 : 110,
      fontWeight: FontWeight.w400,
    );

    final subtitleStyle = GoogleFonts.rockSalt(
      color: Colors.white,
      fontSize: isMobile ? 12 : 24,
      letterSpacing: 2,
    );

    return Selector<hc.HeroController, bool>(
      selector: (context, controller) => controller.isLoaded,
      builder: (context, isLoaded, child) {
        return Flex(
          direction: isMobile ? Axis.vertical : Axis.horizontal,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Left Side Content
            Column(
              crossAxisAlignment: isMobile
                  ? CrossAxisAlignment.center
                  : CrossAxisAlignment.end,
              children: [
                _AnimatedTypographyUnit(
                  text: AppText.heroTitleModern,
                  style: titleStyle,
                  delay: 200,
                  isLoaded: isLoaded,
                ),
                if (!isMobile) const SizedBox(height: 10),
                _AnimatedTypographyUnit(
                  text: AppText.heroCreatedForYou,
                  style: subtitleStyle,
                  delay: 800,
                  isLoaded: isLoaded,
                ),
              ],
            ),

            // Large Gap for the Phone Centerpiece
            SizedBox(width: isMobile ? 0 : 380, height: isMobile ? 320 : 0),

            // Right Side Content
            _AnimatedTypographyUnit(
              text: AppText.heroTitleArchitect,
              style: titleStyle,
              delay: 400,
              isLoaded: isLoaded,
            ),
          ],
        );
      },
    );
  }
}

class _AnimatedTypographyUnit extends StatelessWidget {
  final String text;
  final TextStyle style;
  final int delay;
  final bool isLoaded;

  const _AnimatedTypographyUnit({
    required this.text,
    required this.style,
    required this.delay,
    required this.isLoaded,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedPadding(
      padding: EdgeInsets.only(top: isLoaded ? 0 : 40),
      duration: Duration(milliseconds: 1200 + delay),
      curve: Curves.easeOutExpo,
      child: AnimatedOpacity(
        opacity: isLoaded ? 1.0 : 0.0,
        duration: Duration(milliseconds: 1000 + delay),
        child: Text(text, style: style),
      ),
    );
  }
}

class _PhoneCenterpiece extends StatelessWidget {
  const _PhoneCenterpiece();

  @override
  Widget build(BuildContext context) {
    return Selector<hc.HeroController, bool>(
      selector: (context, controller) => controller.isLoaded,
      builder: (context, isLoaded, child) {
        return AnimatedOpacity(
          opacity: isLoaded ? 1.0 : 0.0,
          duration: const Duration(milliseconds: 1500),
          // Stagger the phone entry slightly after the first typography unit
          curve: const Interval(0.4, 1.0, curve: Curves.easeOutExpo),
          child: RepaintBoundary(
            child: PhoneFrame(
              screen: Container(
                color: const Color(0xFF111111),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.flutter_dash_outlined,
                        color: AppTheme.accent,
                        size: 70,
                      ),
                      const SizedBox(height: 15),
                      Text(
                        AppText.heroPhoneLabel,
                        style: GoogleFonts.bebasNeue(
                          color: Colors.white,
                          fontSize: 28,
                          letterSpacing: 6,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _SideInfoCard extends StatelessWidget {
  final String title;
  final String description;
  final bool isProjectLink;

  const _SideInfoCard({
    required this.title,
    required this.description,
    this.isProjectLink = false,
  });

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveLayout.isMobile(context);

    // Cache styles
    final titleStyle = GoogleFonts.bebasNeue(
      color: Colors.white,
      fontSize: isMobile ? 16 : 22,
      letterSpacing: 2,
    );

    final descStyle = GoogleFonts.inter(
      color: Colors.white.withValues(alpha: 0.4),
      fontSize: 12,
      height: 1.6,
    );

    return Selector<hc.HeroController, bool>(
      selector: (context, controller) => controller.isLoaded,
      builder: (context, isLoaded, child) {
        return AnimatedOpacity(
          opacity: isLoaded ? 1.0 : 0.0,
          duration: const Duration(milliseconds: 2500),
          // Stagger the info cards to appear later
          curve: const Interval(0.6, 1.0, curve: Curves.easeOutExpo),
          child: Container(
            width: isMobile ? 160 : 260,
            padding: EdgeInsets.all(isMobile ? 12 : 24),
            decoration: BoxDecoration(
              color: Color(0xFF1A1A1A).withValues(alpha: 0.4),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.08),
                width: 0.8,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: titleStyle),
                SizedBox(height: isMobile ? 4 : 10),
                Text(description, style: descStyle),
                if (isProjectLink) ...[
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Text(
                        AppText.sideCardWatchPreview,
                        style: GoogleFonts.bebasNeue(
                          color: Colors.white,
                          fontSize: 14,
                          letterSpacing: 1.5,
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Icon(
                        Icons.play_circle_outline,
                        color: Colors.white,
                        size: 16,
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }
}
