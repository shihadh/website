import 'package:flutter/material.dart';
import 'package:shihad_portfolio/core/theme/app_theme.dart';
import 'package:shihad_portfolio/core/constants/text_constants.dart';

class ProjectCard extends StatefulWidget {
  final String title;
  final String description;
  final List<String> tags;
  final bool isFeatured;
  final bool isPrivate;
  final VoidCallback onDemoPressed;
  final VoidCallback onGithubPressed;

  const ProjectCard({
    super.key,
    required this.title,
    required this.description,
    required this.tags,
    this.isFeatured = false,
    this.isPrivate = false,
    required this.onDemoPressed,
    required this.onGithubPressed,
  });

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  bool _isHovered = false;

  void _onHover(PointerEvent event) {
    setState(() => _isHovered = true);
  }

  void _onHoverExit(PointerEvent event) {
    setState(() => _isHovered = false);
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: _onHover,
      onExit: _onHoverExit,
      child: LayoutBuilder(
        builder: (context, constraints) {
          return AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            transform: Matrix4.translationValues(
              0.0,
              _isHovered ? -8.0 : 0.0,
              0.0,
            ),
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: widget.isFeatured ? AppTheme.surface : AppTheme.card,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: widget.isFeatured
                    ? AppTheme.accent.withValues(alpha: 0.5)
                    : (_isHovered
                          ? AppTheme.accent.withValues(alpha: 0.3)
                          : AppTheme.glassBorder),
                width: widget.isFeatured ? 2 : 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(
                    alpha: _isHovered ? 0.35 : 0.3,
                  ),
                  blurRadius: _isHovered ? 25 : 20,
                  offset: Offset(0, _isHovered ? 12 : 10),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (widget.isFeatured)
                  Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: AppTheme.accent,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      AppText.projectFeaturedLabel,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                Text(
                  widget.title,
                  style: Theme.of(
                    context,
                  ).textTheme.displayMedium?.copyWith(fontSize: 28),
                ),
                const SizedBox(height: 12),
                Text(
                  widget.description,
                  style: Theme.of(context).textTheme.bodyLarge,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                const Spacer(),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: widget.tags.map((tag) => _Tag(label: tag)).toList(),
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    if (!widget.isPrivate)
                      _ActionButton(
                        label: AppText.projectLiveDemo,
                        icon: Icons.play_arrow,
                        onPressed: widget.onDemoPressed,
                      ),
                    const SizedBox(width: 12),
                    _ActionButton(
                      label: widget.isPrivate
                          ? AppText.projectPrivate
                          : AppText.projectGithub,
                      icon: widget.isPrivate ? Icons.lock : Icons.code,
                      onPressed: widget.isPrivate
                          ? () {}
                          : widget.onGithubPressed,
                      isOutline: true,
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _Tag extends StatelessWidget {
  final String label;
  const _Tag({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        label,
        style: const TextStyle(fontSize: 12, color: AppTheme.secondary),
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onPressed;
  final bool isOutline;

  const _ActionButton({
    required this.label,
    required this.icon,
    required this.onPressed,
    this.isOutline = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isOutline ? Colors.transparent : AppTheme.primary,
          border: isOutline ? Border.all(color: AppTheme.glassBorder) : null,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 18,
              color: isOutline ? AppTheme.primary : AppTheme.background,
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                color: isOutline ? AppTheme.primary : AppTheme.background,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
