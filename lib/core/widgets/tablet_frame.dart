import 'package:flutter/material.dart';
import 'package:shihad_portfolio/core/theme/app_theme.dart';
import 'package:shihad_portfolio/core/constants/app_constants.dart';

class TabletFrame extends StatelessWidget {
  final Widget screen;
  final double scale;
  final Offset translation;

  const TabletFrame({
    super.key,
    required this.screen,
    this.scale = 1,
    this.translation = Offset.zero,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Calculate max width based on constraints, capped at a reasonable desktop size
        double maxWidth = constraints.maxWidth;
        if (maxWidth > 900) maxWidth = 900;

        final height = maxWidth / AppConstants.tabletAspectRatio;

        return Transform.translate(
          offset: translation,
          child: Transform.scale(
            scale: scale,
            child: Center(
              child: Container(
                width: maxWidth,
                height: height,
                decoration: BoxDecoration(
                  color: AppTheme.surface,
                  borderRadius: BorderRadius.circular(
                    AppConstants.tabletBorderRadius,
                  ),
                  border: Border.all(color: AppTheme.glassBorder, width: 12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.6),
                      blurRadius: 60,
                      offset: const Offset(0, 30),
                    ),
                  ],
                ),
                child: Stack(
                  children: [
                    // Screen Content
                    Padding(
                      padding: const EdgeInsets.all(4), // Bezels
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(
                          AppConstants.tabletBorderRadius - 12,
                        ),
                        child: screen,
                      ),
                    ),
                    // Home Button (Modern thin line)
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 8),
                        width: 120,
                        height: 4,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ),
                    // Reflection Overlay
                    IgnorePointer(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            AppConstants.tabletBorderRadius - 12,
                          ),
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Colors.white.withValues(alpha: 0.05),
                              Colors.transparent,
                              Colors.black.withValues(alpha: 0.1),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
