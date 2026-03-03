import 'package:flutter/material.dart';
import 'package:shihad_portfolio/core/theme/app_theme.dart';
import 'package:shihad_portfolio/core/constants/app_constants.dart';

class PhoneFrame extends StatelessWidget {
  final Widget screen;
  final double rotationY;
  final double scale;
  final Offset translation;

  const PhoneFrame({
    super.key,
    required this.screen,
    this.rotationY = 0,
    this.scale = 1,
    this.translation = Offset.zero,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 300 / AppConstants.phoneAspectRatio,
      decoration: BoxDecoration(
        color: AppTheme.surface,
        borderRadius: BorderRadius.circular(AppConstants.phoneBorderRadius),
        border: Border.all(color: AppTheme.glassBorder, width: 8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.5),
            blurRadius: 40,
            offset: const Offset(0, 20),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Screen Content
          ClipRRect(
            borderRadius: BorderRadius.circular(
              AppConstants.phoneBorderRadius - 8,
            ),
            child: screen,
          ),
          // Camera Notch
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              margin: const EdgeInsets.only(top: 12),
              width: 60,
              height: 20,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          // Reflection Overlay
          IgnorePointer(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  AppConstants.phoneBorderRadius - 8,
                ),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    // Colors.white.withOpacity(0.1),
                    Colors.transparent,
                    Colors.black.withValues(alpha: 0.1),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
