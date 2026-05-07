import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:shihad_portfolio/portfolio/view/home_view.dart';
import 'package:shihad_portfolio/portfolio/view/seo_pages/seo_content.dart';

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();

final GoRouter appRouter = GoRouter(
  navigatorKey: rootNavigatorKey,
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeView(),
    ),
    GoRoute(
      path: '/flutter-developer',
      builder: (context, state) => const FlutterDeveloperPage(),
    ),
    GoRoute(
      path: '/mobile-app-developer',
      builder: (context, state) => const MobileAppDeveloperPage(),
    ),
    GoRoute(
      path: '/flutter-web-developer',
      builder: (context, state) => const FlutterWebDeveloperPage(),
    ),
    GoRoute(
      path: '/business-app-development',
      builder: (context, state) => const BusinessAppDevelopmentPage(),
    ),
    GoRoute(
      path: '/billing-software-development',
      builder: (context, state) => const BillingSoftwareDevelopmentPage(),
    ),
    GoRoute(
      path: '/firebase-integration',
      builder: (context, state) => const FirebaseIntegrationPage(),
    ),
    GoRoute(
      path: '/faq',
      builder: (context, state) => const FaqPage(),
    ),
    GoRoute(
      path: '/contact',
      builder: (context, state) => const ContactSeoPage(),
    ),
  ],
);
