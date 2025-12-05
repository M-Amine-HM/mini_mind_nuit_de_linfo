import 'package:flutter/material.dart';
import '../widgets/animated_text.dart';
import '../widgets/custom_button.dart';
import '../routes/app_routes.dart';

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
    // Réinitialiser la clé à chaque fois que la page est créée
    _animationKey = UniqueKey();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Center(
                child: AnimatedTextWidget(
                  key:
                      _animationKey, // Clé unique pour forcer la réinitialisation
                  texts: [
                    "Bienvenue ! Aujourd'hui, tu vas découvrir l'IA appliquée au développement durable.",
                    "Teste différents concepts et vois comment l'IA peut aider la planète.",
                    "Clique sur Skip pour commencer directement.",
                  ],
                ),
              ),
            ),
            CustomButton(
              text: "Skip",
              onPressed: () {
                Navigator.pushNamed(context, AppRoutes.dashboard);
              },
            ),
          ],
        ),
      ),
    );
  }
}
