import 'package:flutter/material.dart';
import '../pages/intro_page.dart';
import '../pages/dashboard_page.dart';
import '../pages/concept_page.dart';
import '../pages/chatbot_page.dart';
import '../pages/image_page.dart';
import '../pages/classification_page.dart';
import '../pages/agriculture_page.dart';

class AppRoutes {
  static const intro = '/';
  static const dashboard = '/dashboard';
  static const concept = '/concept';
  static const chatbot = '/chatbot';
  static const image = '/image';
  static const classification = '/classification';
  static const agriculture = '/agriculture';

  static final routes = {
    intro: (context) => const IntroPage(),
    dashboard: (context) => const DashboardPage(),
    concept: (context) => const ConceptPage(),
    chatbot: (context) => const ChatbotPage(),
    image: (context) => const ImagePage(),
    classification: (context) => const ClassificationPage(),
    agriculture: (context) => const AgriculturePage(),
  };
}
