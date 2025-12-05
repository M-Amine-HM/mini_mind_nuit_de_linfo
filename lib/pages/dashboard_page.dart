import 'package:flutter/material.dart';
import '../widgets/concept_card.dart';
import '../widgets/animated_text.dart';
import '../config/colors/colors.dart';
import '../routes/app_routes.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final concepts = [
      {
        "title": "NLP / Chatbot",
        "route": AppRoutes.chatbot,
        "icon": Icons.chat_bubble,
      },
      {
        "title": "Vision par ordinateur (CNN)",
        "route": AppRoutes.image,
        "icon": Icons.image,
      },
      {
        "title": "ML supervisé / Classification",
        "route": AppRoutes.classification,
        "icon": Icons.bolt,
      },
      {
        "title": "Prédiction / Modèle prédictif",
        "route": AppRoutes.agriculture,
        "icon": Icons.agriculture,
      },
    ];

    final dashboardDescription = [
      "Bienvenue sur le Dashboard !",
      "Choisis un concept pour tester l'IA appliquée au développement durable.",
      "Chaque concept te permettra de comprendre et expérimenter l'intelligence artificielle de manière ludique.",
    ];

    return Scaffold(
      appBar: AppBar(title: const Text("Dashboard")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Texte descriptif animé en haut
            Expanded(child: AnimatedTextWidget(texts: dashboardDescription)),
            //   const SizedBox(height: 100),
            // Grille des concepts
            Expanded(
              flex: 3,
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
          ],
        ),
      ),
    );
  }
}
