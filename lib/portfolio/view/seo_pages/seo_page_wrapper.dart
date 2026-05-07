import 'package:flutter/material.dart';
import 'package:shihad_portfolio/core/theme/app_theme.dart';
import 'package:go_router/go_router.dart';

class SeoPageWrapper extends StatelessWidget {
  final String title;
  final String description;
  final Widget content;

  const SeoPageWrapper({
    super.key,
    required this.title,
    required this.description,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Title(
      title: title,
      color: AppTheme.primary,
      child: Scaffold(
        backgroundColor: AppTheme.background,
        appBar: AppBar(
          backgroundColor: AppTheme.surface,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: AppTheme.primary),
            onPressed: () {
              if (context.canPop()) {
                context.pop();
              } else {
                context.go('/');
              }
            },
          ),
          title: Text(
            title,
            style: TextStyle(color: AppTheme.primary, fontSize: 18),
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 800),
              child: content,
            ),
          ),
        ),
      ),
    );
  }
}
