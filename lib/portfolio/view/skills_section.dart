import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shihad_portfolio/core/responsive.dart';
import 'package:shihad_portfolio/core/theme/app_theme.dart';
import 'package:shihad_portfolio/core/constants/text_constants.dart';
import 'package:shihad_portfolio/core/widgets/tablet_frame.dart';
import 'package:shihad_portfolio/portfolio/controller/skills_controller.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveLayout.isMobile(context);

    final List<_SkillApp> apps = [
      _SkillApp(
        id: 'languages',
        name: 'Language',
        icon: Icons.language_rounded,
        color: Colors.blue,
        skills: ['flutter', 'dart'],
      ),
      _SkillApp(
        id: 'backend',
        name: 'Backend',
        icon: Icons.cloud_queue_rounded,
        color: Colors.orange,
        skills: ['Firebase', 'Supabase', 'REST APIs', 'Authentication'],
      ),
      _SkillApp(
        id: 'ai',
        name: 'AI & ML',
        icon: Icons.psychology_rounded,
        color: Colors.purple,
        skills: ['ML Kit', 'OpenAI API', 'OCR Integration', 'AI Chat'],
      ),
      _SkillApp(
        id: 'tools',
        name: 'Tools',
        icon: Icons.build_rounded,
        color: Colors.green,
        skills: ['Git', 'Postman', 'VS Code', 'Performance Ops'],
      ),
    ];

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24 : 100,
        vertical: 100,
      ),
      child: Column(
        children: [
          _buildHeader(isMobile),
          const SizedBox(height: 60),
          Selector<SkillsController, bool>(
            selector: (_, c) => c.isVisible,
            builder: (context, isVisible, child) {
              return AnimatedScale(
                scale: isVisible ? 1.0 : 0.8,
                duration: const Duration(milliseconds: 1000),
                curve: Curves.easeOutBack,
                child: AnimatedOpacity(
                  opacity: isVisible ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 800),
                  child: child,
                ),
              );
            },
            child: _buildIpadFrame(context, apps),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(bool isMobile) {
    return Column(
      children: [
        Text(
          AppText.skills['title']!,
          textAlign: TextAlign.center,
          style: GoogleFonts.bebasNeue(
            color: Colors.white,
            fontSize: isMobile ? 48 : 80,
            letterSpacing: 2,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          width: 80,
          height: 4,
          decoration: BoxDecoration(
            color: AppTheme.accent,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
      ],
    );
  }

  Widget _buildIpadFrame(BuildContext context, List<_SkillApp> apps) {
    return TabletFrame(
      screen: Container(
        color: const Color(0xFF121212),
        child: Stack(
          children: [
            // Home Screen
            _buildHomeScreen(context, apps),

            // Opened App Overlay
            Consumer<SkillsController>(
              builder: (context, controller, _) {
                if (controller.openedAppId == null) {
                  return const SizedBox.shrink();
                }
                final app = apps.firstWhere(
                  (a) => a.id == controller.openedAppId,
                );
                return _buildOpenedAppOverlay(context, app);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHomeScreen(BuildContext context, List<_SkillApp> apps) {
    return Column(
      children: [
        // Status Bar
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Selector<SkillsController, String>(
                selector: (_, c) => c.formattedTime,
                builder: (context, time, _) {
                  return Text(
                    time,
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  );
                },
              ),
              const Row(
                children: [
                  Icon(Icons.wifi, color: Colors.white, size: 14),
                  SizedBox(width: 5),
                  Icon(Icons.battery_full, color: Colors.white, size: 14),
                ],
              ),
            ],
          ),
        ),

        // App Grid
        Expanded(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final isSmall = constraints.maxWidth < 600;
              return Padding(
                padding: EdgeInsets.all(isSmall ? 20 : 40),
                child: GridView.count(
                  crossAxisCount: isSmall ? 3 : 4,
                  mainAxisSpacing: isSmall ? 15 : 30,
                  crossAxisSpacing: isSmall ? 15 : 30,
                  children: apps
                      .map((app) => _buildAppIcon(context, app, isSmall))
                      .toList(),
                ),
              );
            },
          ),
        ),

        // Dock
        Selector<SkillsController, String?>(
          selector: (_, c) => c.openedAppId,
          builder: (context, openedAppId, _) {
            if (openedAppId != null) return const SizedBox.shrink();
            return LayoutBuilder(
              builder: (context, constraints) {
                final isSmall = constraints.maxWidth < 600;
                return Container(
                  margin: EdgeInsets.only(
                    bottom: isSmall ? 10 : 20,
                    left: 20,
                    right: 20,
                  ),
                  padding: EdgeInsets.symmetric(
                    vertical: isSmall ? 10 : 15,
                    horizontal: isSmall ? 20 : 30,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.1),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _buildDockIcon(Icons.phone, isSmall),
                      SizedBox(width: isSmall ? 15 : 20),
                      _buildDockIcon(Icons.message, isSmall),
                      SizedBox(width: isSmall ? 15 : 20),
                      _buildDockIcon(Icons.camera_alt, isSmall),
                      SizedBox(width: isSmall ? 15 : 20),
                      _buildDockIcon(Icons.language, isSmall),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ],
    );
  }

  Widget _buildAppIcon(BuildContext context, _SkillApp app, bool isSmall) {
    return GestureDetector(
      onTap: () => context.read<SkillsController>().openApp(app.id),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.all(isSmall ? 10 : 15),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [app.color, app.color.withValues(alpha: 0.7)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(isSmall ? 12 : 15),
              boxShadow: [
                BoxShadow(
                  color: app.color.withValues(alpha: 0.3),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Icon(app.icon, color: Colors.white, size: isSmall ? 30 : 40),
          ),
          const SizedBox(height: 8),
          Flexible(
            child: Text(
              app.name,
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: isSmall ? 10 : 12,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDockIcon(IconData icon, bool isSmall) {
    return Icon(
      icon,
      color: AppTheme.accent.withValues(alpha: 0.8),
      size: isSmall ? 24 : 30,
    );
  }

  Widget _buildOpenedAppOverlay(BuildContext context, _SkillApp app) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeOutExpo,
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Transform.scale(
            scale: 0.8 + (0.2 * value),
            child: Container(
              color: const Color(0xFF1E1E1E),
              child: Column(
                children: [
                  // App Navbar
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      children: [
                        IconButton(
                          icon: const Icon(
                            Icons.arrow_back_ios,
                            color: AppTheme.accent,
                          ),
                          onPressed: () =>
                              context.read<SkillsController>().closeApp(),
                        ),
                        Text(
                          app.name,
                          style: GoogleFonts.inter(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // App Content
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: ListView(
                        children: [
                          const SizedBox(height: 20),
                          ...app.skills.map(
                            (skill) => _buildSkillListItem(skill),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildSkillListItem(String skill) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
      ),
      child: Row(
        children: [
          const Icon(Icons.check_circle_outline, color: AppTheme.accent),
          const SizedBox(width: 15),
          Text(
            skill,
            style: GoogleFonts.inter(color: Colors.white, fontSize: 18),
          ),
        ],
      ),
    );
  }
}

class _SkillApp {
  final String id;
  final String name;
  final IconData icon;
  final Color color;
  final List<String> skills;

  _SkillApp({
    required this.id,
    required this.name,
    required this.icon,
    required this.color,
    required this.skills,
  });
}
