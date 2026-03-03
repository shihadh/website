import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shihad_portfolio/core/theme/app_theme.dart';
import 'package:shihad_portfolio/core/responsive.dart';
import 'package:shihad_portfolio/core/constants/link_constants.dart';
import 'package:shihad_portfolio/core/constants/text_constants.dart';
import 'package:shihad_portfolio/core/utils/url_launcher_utils.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: ResponsiveLayout.isMobile(context) ? 24 : 100,
        vertical: 100,
      ),
      decoration: const BoxDecoration(color: AppTheme.surface),
      child: Column(
        children: [
          Text(
            AppText.contactTitle,
            style: Theme.of(context).textTheme.displayMedium,
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
    );
  }
}

class _ContactCard extends StatefulWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _ContactCard({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  State<_ContactCard> createState() => _ContactCardState();
}

class _ContactCardState extends State<_ContactCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        transform: Matrix4.identity()
          ..scaleByDouble(
            _isHovered ? 1.05 : 1.0,
            _isHovered ? 1.05 : 1.0,
            1.0,
            1.0,
          ),
        child: InkWell(
          onTap: widget.onTap,
          borderRadius: BorderRadius.circular(16),
          child: Container(
            width: 180,
            padding: const EdgeInsets.symmetric(vertical: 30),
            decoration: BoxDecoration(
              color: AppTheme.card,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppTheme.glassBorder),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: _isHovered ? 0.4 : 0.3),
                  blurRadius: _isHovered ? 30 : 20,
                  offset: Offset(0, _isHovered ? 15 : 10),
                ),
              ],
            ),
            child: Column(
              children: [
                Icon(widget.icon, color: AppTheme.accent, size: 32),
                const SizedBox(height: 12),
                Text(
                  widget.label,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _WhatsAppButton extends StatefulWidget {
  final VoidCallback onTap;
  const _WhatsAppButton({required this.onTap});

  @override
  State<_WhatsAppButton> createState() => _WhatsAppButtonState();
}

class _WhatsAppButtonState extends State<_WhatsAppButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        transform: Matrix4.identity()
          ..scaleByDouble(
            _isHovered ? 1.05 : 1.0,
            _isHovered ? 1.05 : 1.0,
            1.0,
            1.0,
          ),
        child: InkWell(
          onTap: widget.onTap,
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
                  ).withValues(alpha: _isHovered ? 0.5 : 0.3),
                  blurRadius: _isHovered ? 40 : 20,
                  offset: Offset(0, _isHovered ? 15 : 10),
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
      ),
    );
  }
}
