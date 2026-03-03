import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shihad_portfolio/portfolio/hero_controller.dart' as hc;
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
    return Container(
      height: 800,
      width: double.infinity,
      color: AppTheme.background,
      child: Stack(
        children: [
          // Radial Glow Background
          const Positioned.fill(child: _RadialBackgroundGlow()),

          // Massive Background Text: FLUTTER ENGINEER
          const Positioned.fill(child: _BackgroundText()),

          // Centerpiece: PhoneFrame (Floating)
          const Center(child: _PhoneCenterpiece()),

          // Typography Overlays: Split Layout
          const Positioned(
            left: 0,
            right: 0,
            top: 80,
            child: _TypographyOverlay(),
          ),

          // Sidebar Info: Bottom Left Area
          const Positioned(
            bottom: 90,
            left: 80,
            child: _SideInfoCard(
              title: AppText.sideCardPreOrdersTitle,
              description: AppText.sideCardPreOrdersDesc,
            ),
          ),

          // Sidebar Info: Bottom Right Area
          const Positioned(
            bottom: 90,
            right: 80,
            child: _SideInfoCard(
              title: AppText.sideCardExclusiveTitle,
              description: AppText.sideCardExclusiveDesc,
              isProjectLink: true,
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
    return Container(
      decoration: BoxDecoration(
        gradient: RadialGradient(
          center: const Alignment(0, 0),
          radius: 0.8,
          colors: [AppTheme.accent.withValues(alpha: 0.06), Colors.transparent],
        ),
      ),
    );
  }
}

class _BackgroundText extends StatelessWidget {
  const _BackgroundText();

  @override
  Widget build(BuildContext context) {
    return Selector<hc.HeroController, bool>(
      selector: (context, controller) => controller.isLoaded,
      builder: (context, isLoaded, child) {
        final textStyle = GoogleFonts.bebasNeue(
          fontSize: 260,
          fontWeight: FontWeight.w900,
          letterSpacing: 2,
          color: Colors.white,
          height: 0.8,
        );

        return Stack(
          alignment: Alignment.center,
          children: [
            // "FLUTTER" - Sliding from Left
            AnimatedPositioned(
              duration: const Duration(milliseconds: 3000),
              curve: Curves.easeOutExpo,
              left: isLoaded ? 0 : -400,
              right: isLoaded ? 0 : 400,
              top: 200,
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 2000),
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
              duration: const Duration(milliseconds: 3000),
              curve: Curves.easeOutExpo,
              left: isLoaded ? 0 : 400,
              right: isLoaded ? 0 : -400,
              bottom: 200,
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 2000),
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
    return Selector<hc.HeroController, bool>(
      selector: (context, controller) => controller.isLoaded,
      builder: (context, isLoaded, child) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Left Side Content
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                _AnimatedTypographyUnit(
                  text: AppText.heroTitleModern,
                  style: GoogleFonts.kaushanScript(
                    color: AppTheme.accent,
                    fontSize: 110,
                    fontWeight: FontWeight.w400,
                  ),
                  delay: 200,
                  isLoaded: isLoaded,
                ),
                const SizedBox(height: 10),
                _AnimatedTypographyUnit(
                  text: AppText.heroCreatedForYou,
                  style: GoogleFonts.rockSalt(
                    color: Colors.white,
                    fontSize: 24,
                    letterSpacing: 2,
                  ),
                  delay: 800,
                  isLoaded: isLoaded,
                ),
              ],
            ),

            // Large Gap for the Phone Centerpiece
            const SizedBox(width: 380),

            // Right Side Content
            _AnimatedTypographyUnit(
              text: AppText.heroTitleArchitect,
              style: GoogleFonts.kaushanScript(
                color: AppTheme.accent,
                fontSize: 110,
                fontWeight: FontWeight.w400,
              ),
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
    return Consumer<hc.HeroController>(
      builder: (context, controller, child) {
        final isLoaded = controller.isLoaded;
        // final scrollObj = controller.scrollProgress;

        return AnimatedContainer(
          duration: const Duration(milliseconds: 2000),
          curve: Curves.easeOutExpo,
          child: AnimatedOpacity(
            opacity: isLoaded ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 1500),
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
    return Selector<hc.HeroController, bool>(
      selector: (context, controller) => controller.isLoaded,
      builder: (context, isLoaded, child) {
        return AnimatedOpacity(
          opacity: isLoaded ? 1.0 : 0.0,
          duration: const Duration(milliseconds: 2500),
          child: Container(
            width: 260,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: const Color(0xFF1A1A1A).withValues(alpha: 0.4),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.08),
                width: 0.8,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.bebasNeue(
                    color: Colors.white,
                    fontSize: 22,
                    letterSpacing: 2,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  description,
                  style: GoogleFonts.inter(
                    color: Colors.white.withValues(alpha: 0.4),
                    fontSize: 12,
                    height: 1.6,
                  ),
                ),
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
