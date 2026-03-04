import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shihad_portfolio/core/theme/app_theme.dart';
import 'package:shihad_portfolio/core/constants/link_constants.dart';
import 'package:shihad_portfolio/core/constants/text_constants.dart';
import 'package:shihad_portfolio/core/utils/url_launcher_utils.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A).withValues(alpha: 0.4),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.08),
          width: 0.8,
        ),
      ),
      child: RepaintBoundary(
        child: Column(
          children: [
            Text(
              AppText.contactTitle,
              style: GoogleFonts.kaushanScript(
                color: AppTheme.accent,
                fontSize: 50,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              AppText.contactSubtitle,
              textAlign: TextAlign.center,
              style: TextStyle(color: AppTheme.secondary, fontSize: 18),
            ),
            const SizedBox(height: 60),
            Wrap(
              spacing: 20,
              runSpacing: 20,
              alignment: WrapAlignment.center,
              children: [
                _ContactCard(
                  icon: Icons.email_outlined,
                  label: AppText.contactEmailLabel,
                  onTap: () async {
                    await Clipboard.setData(
                      const ClipboardData(text: AppLinks.email),
                    );
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(AppText.contactEmailCopied),
                          duration: Duration(seconds: 2),
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    }
                    // Still try to open mail client as a bonus
                    UrlLauncherUtils.launchURL('mailto:${AppLinks.email}');
                  },
                ),
                _ContactCard(
                  icon: Icons.link,
                  label: AppText.contactLinkedInLabel,
                  onTap: () => UrlLauncherUtils.launchURL(AppLinks.linkedIn),
                ),
                _ContactCard(
                  icon: Icons.code,
                  label: AppText.contactGithubLabel,
                  onTap: () => UrlLauncherUtils.launchURL(AppLinks.github),
                ),
                _WhatsAppButton(
                  onTap: () => UrlLauncherUtils.launchURL(AppLinks.whatsapp),
                ),
              ],
            ),
            const SizedBox(height: 80),
            const Text(
              AppText.contactCopyright,
              style: TextStyle(color: AppTheme.secondary, fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}

class _ContactCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _ContactCard({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final hoverNotifier = ValueNotifier<bool>(false);

    return ValueListenableProvider<bool>.value(
      value: hoverNotifier,
      child: MouseRegion(
        onEnter: (_) => hoverNotifier.value = true,
        onExit: (_) => hoverNotifier.value = false,
        child: Consumer<bool>(
          builder: (context, isHovered, _) {
            return AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              transform: Matrix4.identity()
                ..scaleByDouble(
                  isHovered ? 1.05 : 1.0,
                  isHovered ? 1.05 : 1.0,
                  1.0,
                  1.0,
                ),
              child: InkWell(
                onTap: onTap,
                borderRadius: BorderRadius.circular(16),
                child: Container(
                  width: 180,
                  padding: const EdgeInsets.symmetric(vertical: 30),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1A1A1A).withValues(alpha: 0.4),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: AppTheme.glassBorder),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(
                          alpha: isHovered ? 0.4 : 0.3,
                        ),
                        blurRadius: isHovered ? 30 : 20,
                        offset: Offset(0, isHovered ? 15 : 10),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Icon(icon, color: AppTheme.accent, size: 32),
                      const SizedBox(height: 12),
                      Text(
                        label,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _WhatsAppButton extends StatelessWidget {
  final VoidCallback onTap;
  const _WhatsAppButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    final hoverNotifier = ValueNotifier<bool>(false);

    return ValueListenableProvider<bool>.value(
      value: hoverNotifier,
      child: MouseRegion(
        onEnter: (_) => hoverNotifier.value = true,
        onExit: (_) => hoverNotifier.value = false,
        child: Consumer<bool>(
          builder: (context, isHovered, _) {
            return AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              transform: Matrix4.identity()
                ..scaleByDouble(
                  isHovered ? 1.05 : 1.0,
                  isHovered ? 1.05 : 1.0,
                  1.0,
                  1.0,
                ),
              child: InkWell(
                onTap: onTap,
                borderRadius: BorderRadius.circular(16),
                child: Container(
                  width: 180,
                  padding: const EdgeInsets.symmetric(vertical: 30),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF25D366), Color(0xFF128C7E)],
                    ),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(
                          0xFF25D366,
                        ).withValues(alpha: isHovered ? 0.5 : 0.3),
                        blurRadius: isHovered ? 40 : 20,
                        offset: Offset(0, isHovered ? 15 : 10),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      const Icon(
                        Icons.chat_bubble_outline,
                        color: Colors.white,
                        size: 32,
                      ),
                      const SizedBox(height: 12),
                      Text(
                        AppText.contactWhatsAppLabel,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
