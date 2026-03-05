import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shihad_portfolio/core/responsive.dart';
import 'package:shihad_portfolio/core/constants/link_constants.dart';
import 'package:shihad_portfolio/core/constants/text_constants.dart';
import 'package:shihad_portfolio/core/theme/app_theme.dart';
import 'package:shihad_portfolio/core/utils/url_launcher_utils.dart';
import 'package:shihad_portfolio/showcase/project_card.dart';
import 'package:shihad_portfolio/demo/demo_provider.dart';

class ShowcaseSection extends StatelessWidget {
  const ShowcaseSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveLayout.isMobile(context);
    final demoProvider = context.read<DemoProvider>();

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24 : 100,
        vertical: 100,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            AppText.showcase['title']!,
            textAlign: TextAlign.center,
            style: GoogleFonts.bebasNeue(
              color: Colors.white,
              fontSize: isMobile ? 48 : 80,
            ),
          ),
          SizedBox(height: isMobile ? 8 : 16),
          Text(
            AppText.showcase['subtitle']!,
            textAlign: TextAlign.center,
            style: GoogleFonts.rockSalt(
              color: AppTheme.accent,
              fontSize: isMobile ? 14 : 24,
            ),
          ),
          SizedBox(height: isMobile ? 40 : 60),
          _buildProjectGrid(context, demoProvider),
        ],
      ),
    );
  }

  Widget _buildProjectGrid(BuildContext context, DemoProvider demoProvider) {
    final projects = [
      ProjectCard(
        title: AppText.projectData['finoteTitle']!,
        description: AppText.projectData['finoteDesc']!,
        tags: const ['Flutter', 'Firebase', 'AI-Integration', 'Provider'],
        isFeatured: true,
        onDemoPressed: () => demoProvider.openDemo(DemoType.finote),
        onGithubPressed: () {
          UrlLauncherUtils.launchURL(AppLinks.finoteGithub);
        },
      ),
      ProjectCard(
        title: AppText.projectData['carRentalTitle']!,
        description: AppText.projectData['carRentalDesc']!,
        tags: const ['Flutter', 'Clean Architecture', 'Provider'],
        onDemoPressed: () => demoProvider.openDemo(DemoType.carRental),
        onGithubPressed: () {
          UrlLauncherUtils.launchURL(AppLinks.carRentalGithub);
        },
      ),
      ProjectCard(
        title: AppText.projectData['gameVerseProjectTitle']!,
        description: AppText.projectData['gameVerseDesc']!,
        tags: const ['Flutter', 'REST API', 'GameDB', 'Provider'],
        onDemoPressed: () => demoProvider.openDemo(DemoType.gameVerse),
        onGithubPressed: () {
          UrlLauncherUtils.launchURL(AppLinks.gameVerseGithub);
        },
      ),
      ProjectCard(
        title: AppText.projectData['icmsTitle']!,
        description: AppText.projectData['icmsDesc']!,
        tags: const ['Flutter', 'Enterprise', 'REST API', 'Provider'],
        isPrivate: true,
        onDemoPressed: () {},
        onGithubPressed: () {
          UrlLauncherUtils.launchURL(AppLinks.icmsGithub);
        },
      ),
    ];

    if (ResponsiveLayout.isMobile(context)) {
      return Column(
        children: projects
            .map(
              (p) => Padding(
                padding: const EdgeInsets.only(bottom: 24),
                child: SizedBox(height: 400, child: p),
              ),
            )
            .toList(),
      );
    }

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 32,
        mainAxisSpacing: 32,
        mainAxisExtent: 450,
      ),
      itemCount: projects.length,
      itemBuilder: (context, index) => projects[index],
    );
  }
}
