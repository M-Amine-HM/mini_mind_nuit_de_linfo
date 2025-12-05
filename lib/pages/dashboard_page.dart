import 'package:flutter/material.dart';
import '../widgets/concept_card.dart';
import '../routes/app_routes.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final concepts = [
      {
        "title": "Chatbot",
        "route": AppRoutes.chatbot,
        "icon": Icons.chat_bubble,
        "color": Colors.blue,
        "description": "Discute avec une IA écologique",
      },
      {
        "title": "Vision CNN",
        "route": AppRoutes.image,
        "icon": Icons.image,
        "color": Colors.green,
        "description": "Reconnaît et classe les images",
      },
      {
        "title": "Classification",
        "route": AppRoutes.classification,
        "icon": Icons.category,
        "color": Colors.purple,
        "description": "Apprends à trier les données",
      },
      {
        "title": "Prédiction",
        "route": AppRoutes.agriculture,
        "icon": Icons.agriculture,
        "color": Colors.orange,
        "description": "Prédit la meilleure culture",
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("MiniMind 🌿"),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Message de bienvenue
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.green.shade300, Colors.blue.shade300],
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Column(
                children: [
                  Icon(Icons.eco, size: 50, color: Colors.white),
                  SizedBox(height: 10),
                  Text(
                    "IA & Développement Durable",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Titre
            const Text(
              "Choisis un module 👇",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 16),

            // Grille des modules
            Expanded(
              child: GridView.builder(
                itemCount: concepts.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                ),
                itemBuilder: (context, index) {
                  final concept = concepts[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, concept["route"] as String);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: (concept["color"] as Color).withOpacity(0.2),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: concept["color"] as Color,
                          width: 2,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            concept["icon"] as IconData,
                            size: 50,
                            color: concept["color"] as Color,
                          ),
                          const SizedBox(height: 12),
                          Text(
                            concept["title"] as String,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Text(
                              concept["description"] as String,
                              style: const TextStyle(fontSize: 12),
                              textAlign: TextAlign.center,
                              maxLines: 2,
                            ),
                          ),
                        ],
                      ),
                    ),
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
