import 'package:flutter/material.dart';

class PortfolioController extends ChangeNotifier {
  final ScrollController scrollController = ScrollController();

  final GlobalKey showcaseKey = GlobalKey();
  final GlobalKey skillsKey = GlobalKey();
  final GlobalKey contactKey = GlobalKey();

  void scrollToWork() {
    if (showcaseKey.currentContext != null) {
      Scrollable.ensureVisible(
        showcaseKey.currentContext!,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOutExpo,
      );
    }
  }

  void scrollToContact() {
    if (contactKey.currentContext != null) {
      Scrollable.ensureVisible(
        contactKey.currentContext!,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOutExpo,
      );
    }
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
}
