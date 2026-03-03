import 'package:flutter/material.dart';

class PortfolioController extends ChangeNotifier {
  final ScrollController scrollController = ScrollController();

  final GlobalKey showcaseKey = GlobalKey();
  final GlobalKey contactKey = GlobalKey();

  double scrollOffset = 0.0;

  PortfolioController() {
    scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    scrollOffset = scrollController.offset;
    notifyListeners();
  }

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
    scrollController.removeListener(_onScroll);
    scrollController.dispose();
    super.dispose();
  }
}
