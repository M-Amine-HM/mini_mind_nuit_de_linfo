import 'package:flutter/material.dart';
import '../widgets/concept_card.dart';
//import '../config/colors.dart';
import '../routes/app_routes.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final concepts = [
      {
        "title": "Chatbot Durable",
        "route": AppRoutes.chatbot,
        "icon": Icons.chat_bubble,
      },
      {
        "title": "Reconnaissance Déchets",
        "route": AppRoutes.image,
        "icon": Icons.image,
      },
      {
        "title": "Classification Énergie",
        "route": AppRoutes.classification,
        "icon": Icons.bolt,
      },
      {
        "title": "Agriculture Intelligente",
        "route": AppRoutes.agriculture,
        "icon": Icons.agriculture,
      },
    ];

    return Scaffold(
      appBar: AppBar(title: const Text("Dashboard")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          itemCount: concepts.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
          ),
          itemBuilder: (context, index) {
            final concept = concepts[index];
            return ConceptCard(
              title: concept["title"] as String,
              icon: concept["icon"] as IconData,
              onTap: () {
                Navigator.pushNamed(context, concept["route"] as String);
              },
            );
          },
        ),
      ),
    );
  }
}
