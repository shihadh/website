import 'package:flutter/material.dart';
import 'package:shihad_portfolio/core/theme/app_theme.dart';
import 'package:shihad_portfolio/portfolio/view/seo_pages/seo_page_wrapper.dart';

Widget _buildHeading(String text) {
  return Padding(
    padding: const EdgeInsets.only(top: 32, bottom: 16),
    child: Text(
      text,
      style: const TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.bold,
        color: AppTheme.accent,
      ),
    ),
  );
}

Widget _buildParagraph(String text) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 16),
    child: Text(
      text,
      style: const TextStyle(
        fontSize: 16,
        height: 1.6,
        color: AppTheme.secondary,
      ),
    ),
  );
}

Widget _buildList(List<String> items) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 24, left: 16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: items.map((item) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('• ', style: TextStyle(color: AppTheme.accent, fontSize: 18)),
              Expanded(
                child: Text(
                  item,
                  style: const TextStyle(fontSize: 16, height: 1.5, color: AppTheme.secondary),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    ),
  );
}

// 1. Flutter Developer
class FlutterDeveloperPage extends StatelessWidget {
  const FlutterDeveloperPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SeoPageWrapper(
      title: 'Expert Flutter Developer | Hire Top Flutter App Developer',
      description: 'Hire an expert Flutter Developer for building high-performance, responsive cross-platform mobile and web applications.',
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeading('Expert Flutter Developer Services'),
          _buildParagraph('As a specialized Flutter developer, I build beautiful, natively compiled, multi-platform applications from a single codebase. My focus is on delivering seamless performance, expressive UIs, and robust architectures for modern businesses.'),
          _buildHeading('Why Choose Flutter?'),
          _buildList([
            'Fast Development: Single codebase for iOS, Android, and Web.',
            'Native Performance: Compiles directly to ARM machine code.',
            'Expressive UI: Custom, beautiful designs with rich animations.',
          ]),
          _buildHeading('My Flutter Expertise'),
          _buildParagraph('With extensive experience in state management (Provider, Riverpod, BLoC), clean architecture, and API integration, I ensure that your application is scalable and maintainable.'),
        ],
      ),
    );
  }
}

// 2. Mobile App Developer
class MobileAppDeveloperPage extends StatelessWidget {
  const MobileAppDeveloperPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SeoPageWrapper(
      title: 'Professional Mobile App Developer | iOS & Android App Development',
      description: 'Professional Mobile App Developer specializing in custom iOS and Android applications. Get high-quality, scalable mobile solutions for your business.',
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeading('Professional Mobile App Development'),
          _buildParagraph('I provide end-to-end mobile app development services, delivering top-tier solutions for both iOS and Android platforms. Whether you need a startup MVP or an enterprise-grade mobile solution, I have the skills to bring your vision to life.'),
          _buildHeading('My Mobile App Services'),
          _buildList([
            'Custom iOS and Android app development using Flutter.',
            'UI/UX design implementation.',
            'Backend integration and API development.',
            'App Store and Google Play deployment.',
          ]),
        ],
      ),
    );
  }
}

// 3. Flutter Web Developer
class FlutterWebDeveloperPage extends StatelessWidget {
  const FlutterWebDeveloperPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SeoPageWrapper(
      title: 'Flutter Web Developer | Modern Web App Development',
      description: 'Expert Flutter Web Developer building highly interactive, fast, and responsive web applications with a native-app feel.',
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeading('Modern Flutter Web Development'),
          _buildParagraph('Flutter is no longer just for mobile. As an experienced Flutter Web Developer, I leverage the power of Flutter to create highly interactive, rich web experiences that perform like native applications.'),
          _buildHeading('Web Development Focus'),
          _buildList([
            'Responsive web applications tailored for all screen sizes.',
            'SEO, GEO, and AEO optimized architecture.',
            'Progressive Web Apps (PWA) support.',
            'Complex dashboards and data-heavy web portals.',
          ]),
        ],
      ),
    );
  }
}

// 4. Business App Development
class BusinessAppDevelopmentPage extends StatelessWidget {
  const BusinessAppDevelopmentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SeoPageWrapper(
      title: 'Custom Business App Development | Scalable Enterprise Solutions',
      description: 'Custom Business App Development services tailored for enterprises and startups. Improve operational efficiency with bespoke software solutions.',
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeading('Custom Business App Development'),
          _buildParagraph('Every business has unique challenges. I specialize in developing custom business applications that streamline operations, improve productivity, and drive digital transformation.'),
          _buildHeading('Solutions I Provide'),
          _buildList([
            'Internal tooling and management dashboards.',
            'B2B software solutions.',
            'Inventory and resource management apps.',
            'Secure, scalable enterprise mobility solutions.',
          ]),
        ],
      ),
    );
  }
}

// 5. Billing Software Development
class BillingSoftwareDevelopmentPage extends StatelessWidget {
  const BillingSoftwareDevelopmentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SeoPageWrapper(
      title: 'Billing Software & POS Developer | Custom Invoicing Solutions',
      description: 'Develop custom Billing Software and POS systems. High-performance software for retail, restaurants, and enterprise invoicing.',
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeading('Billing Software & POS Systems'),
          _buildParagraph('I design and develop robust point-of-sale (POS) and billing software. My applications are built for high reliability, offline support, and seamless hardware integration (like Bluetooth thermal printers and barcode scanners).'),
          _buildHeading('Key POS Features'),
          _buildList([
            'Real-time inventory tracking and synchronization.',
            'Bluetooth thermal printing support.',
            'Customizable invoice generation.',
            'Offline-first capabilities with auto-sync.',
          ]),
        ],
      ),
    );
  }
}

// 6. Firebase Integration
class FirebaseIntegrationPage extends StatelessWidget {
  const FirebaseIntegrationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SeoPageWrapper(
      title: 'Firebase Developer | Expert Firebase Integration Services',
      description: 'Expert Firebase Developer offering real-time database, authentication, cloud functions, and analytics integration for Flutter apps.',
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeading('Expert Firebase Integration'),
          _buildParagraph('Firebase is a powerful backend-as-a-service. As a Firebase Developer, I build secure, scalable, real-time applications using the full suite of Firebase products.'),
          _buildHeading('Firebase Services I Implement'),
          _buildList([
            'Cloud Firestore & Realtime Database for instant data sync.',
            'Firebase Authentication (Social Logins, Email, Phone).',
            'Cloud Functions for scalable serverless backend logic.',
            'Firebase Cloud Messaging (FCM) for push notifications.',
          ]),
        ],
      ),
    );
  }
}

// 7. FAQ Page
class FaqPage extends StatelessWidget {
  const FaqPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SeoPageWrapper(
      title: 'Frequently Asked Questions | Shihad Flutter Developer',
      description: 'Frequently asked questions about my Flutter development services, technical expertise, and project workflows.',
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeading('Frequently Asked Questions'),
          _buildParagraph('Here are some common questions about my services and expertise.'),
          _FaqItem(
            question: 'Who is this Flutter developer?',
            answer: 'I am a Senior Flutter Developer with extensive experience in creating high-performance cross-platform applications for mobile and web. I specialize in modern UI/UX implementation and scalable software architecture.',
          ),
          _FaqItem(
            question: 'What services do you provide?',
            answer: 'I provide end-to-end mobile and web app development, custom business app creation, POS and billing software development, and deep Firebase integration.',
          ),
          _FaqItem(
            question: 'Do you build Android and iOS apps?',
            answer: 'Yes, I build both Android and iOS apps using Flutter, allowing for a single codebase with native performance and feel.',
          ),
          _FaqItem(
            question: 'Do you build Flutter Web apps?',
            answer: 'Absolutely. I build responsive, SEO-optimized web applications using Flutter Web.',
          ),
          _FaqItem(
            question: 'Can you build POS and billing software?',
            answer: 'Yes, I have significant experience building POS applications, complete with inventory management and Bluetooth thermal printer integrations.',
          ),
        ],
      ),
    );
  }
}

class _FaqItem extends StatelessWidget {
  final String question;
  final String answer;

  const _FaqItem({required this.question, required this.answer});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: ExpansionTile(
        title: Text(
          question,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: AppTheme.primary),
        ),
        collapsedIconColor: AppTheme.accent,
        iconColor: AppTheme.accent,
        childrenPadding: const EdgeInsets.all(16),
        children: [
          Text(
            answer,
            style: const TextStyle(fontSize: 16, height: 1.5, color: AppTheme.secondary),
          ),
        ],
      ),
    );
  }
}

// 8. Contact Page
class ContactSeoPage extends StatelessWidget {
  const ContactSeoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SeoPageWrapper(
      title: 'Contact Shihad | Hire Top Flutter Developer',
      description: 'Contact Shihad, an expert Flutter Developer, to discuss your next mobile or web application project.',
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeading('Get In Touch'),
          _buildParagraph('Ready to build something amazing? Let\'s discuss your project requirements and see how we can work together to create an exceptional app.'),
          _buildParagraph('Email: mohammedshihadk1@gmail.com'),
          _buildParagraph('LinkedIn: https://www.linkedin.com/in/mohammed-shihadh-k-/'),
          _buildParagraph('GitHub: github.com/shihadh'),
          // The user already has a ContactSection on the homepage, so this acts as a lightweight SEO landing version
        ],
      ),
    );
  }
}
