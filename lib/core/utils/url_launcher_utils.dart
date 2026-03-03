import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';

class UrlLauncherUtils {
  static Future<void> launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    try {
      if (await canLaunchUrl(uri)) {
        await launchUrl(
          uri,
          mode: url.startsWith('mailto:')
              ? LaunchMode.externalApplication
              : LaunchMode.platformDefault,
        );
      } else {
        debugPrint('Could not launch $url');
      }
    } catch (e) {
      debugPrint('Error launching $url: $e');
    }
  }
}
