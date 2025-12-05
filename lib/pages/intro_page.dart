import 'package:flutter/material.dart';
import '../widgets/animated_text.dart';
import '../widgets/custom_button.dart';
import '../routes/app_routes.dart';
import '../config/colors/colors.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({super.key});

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  Key _animationKey = UniqueKey();

  @override
  void initState() {
    super.initState();
    _animationKey = UniqueKey();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [AppColors.background, AppColors.accent.withOpacity(0.1)],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo ou icône
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.secondary.withOpacity(0.3),
                      blurRadius: 20,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.eco,
                  size: 80,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(height: 40),

              Expanded(
                child: Center(
                  child: DefaultTextStyle(
                    style: TextStyle(color: AppColors.primary, fontSize: 16),
                    child: AnimatedTextWidget(
                      key: _animationKey,
                      texts: [
                        // Bienvenue
                        "👋 Bienvenue dans MiniMind !\n\n"
                            "Une aventure pour découvrir l'Intelligence Artificielle "
                            "et le développement durable.",

                        // Définition IA
                        "🤖 Qu'est-ce que l'IA ?\n\n"
                            "L'Intelligence Artificielle, c'est quand un ordinateur "
                            "apprend à résoudre des problèmes tout seul, comme reconnaître "
                            "des images ou prédire le futur !",

                        // Définition développement durable
                        "🌍 C'est quoi le développement durable ?\n\n"
                            "C'est protéger notre planète en utilisant les ressources "
                            "intelligemment : recycler, économiser l'énergie, "
                            "et préserver la nature pour les générations futures.",

                        // Comment l'IA aide
                        "💡 Comment l'IA aide la planète ?\n\n"
                            "• Elle trie automatiquement les déchets ♻️\n"
                            "• Elle prédit la météo pour l'agriculture 🌾\n"
                            "• Elle optimise la consommation d'énergie ⚡\n"
                            "• Elle détecte la pollution 🌫️",

                        // Ce que tu vas apprendre
                        "🎯 Ce que tu vas découvrir :\n\n"
                            "✅ Vision par ordinateur (CNN)\n"
                            "✅ Classification intelligente\n"
                            "✅ Prédictions avec l'IA\n"
                            "✅ Chatbot écologique\n"
                            "✅ Clustering pour regrouper des données",

                        // Message final
                        "🚀 Prêt(e) à explorer ?\n\n"
                            "Chaque module te montrera comment l'IA et l'écologie "
                            "peuvent changer le monde ensemble.\n\n"
                            "Clique sur 'Commencer' pour débuter l'aventure !",
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Indicateur de progression
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  6,
                  (index) => Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: AppColors.secondary.withOpacity(0.4),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),

              // Bouton
              CustomButton(
                text: "Commencer l'aventure",
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.dashboard);
                },
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
