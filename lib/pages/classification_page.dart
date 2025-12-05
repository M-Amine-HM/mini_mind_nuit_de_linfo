import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import '../config/colors/colors.dart';

class MLClassificationPage extends StatefulWidget {
  const MLClassificationPage({super.key});

  @override
  State<MLClassificationPage> createState() => _MLClassificationPageState();
}

class _MLClassificationPageState extends State<MLClassificationPage>
    with SingleTickerProviderStateMixin {
  bool showIntro = true;
  bool showTraining = false;
  bool showTesting = false;
  String? selectedImage;
  String? prediction;
  int correctAnswers = 0;
  int totalAttempts = 0;

  final List<Map<String, dynamic>> trainingData = [
    {
      "path": "lib/assets/images/leaf.jpg",
      "category": "Nature",
      "icon": "🌿",
      "description": "Plantes et végétation",
    },
    {
      "path": "lib/assets/images/trash.jpg",
      "category": "Déchets",
      "icon": "♻️",
      "description": "Déchets recyclables",
    },
    {
      "path": "lib/assets/images/smoke.png",
      "category": "Pollution",
      "icon": "🌫️",
      "description": "Pollution industrielle",
    },
  ];

  final List<Map<String, dynamic>> testImages = [
    {
      "path": "lib/assets/images/bottle.jpg",
      "correctCategory": "Déchets",
      "icon": "♻️",
    },
    {
      "path": "lib/assets/images/carton.jpg",
      "correctCategory": "Déchets",
      "icon": "♻️",
    },
    {
      "path": "lib/assets/images/apple.png",
      "correctCategory": "Nature",
      "icon": "🌿",
    },
  ];

  void skipIntro() {
    if (!mounted) return;
    setState(() {
      showIntro = false;
      showTraining = true;
    });
  }

  void startTesting() {
    if (!mounted) return;
    setState(() {
      showTraining = false;
      showTesting = true;
      correctAnswers = 0;
      totalAttempts = 0;
    });
  }

  void checkAnswer(String userCategory, String correctCategory) {
    setState(() {
      totalAttempts++;
      if (userCategory == correctCategory) {
        correctAnswers++;
      }
    });
  }

  void resetQuiz() {
    setState(() {
      showTesting = false;
      showTraining = true;
      prediction = null;
      selectedImage = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Classification ML 🎯"),
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.accent,
      ),
      backgroundColor: AppColors.background,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: showIntro
            ? buildIntro()
            : showTraining
            ? buildTrainingPhase()
            : buildTestingPhase(),
      ),
    );
  }

  // Phase 1: Introduction
  Widget buildIntro() {
    return Column(
      children: [
        Expanded(
          child: Center(
            child: DefaultTextStyle(
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
              textAlign: TextAlign.center,
              child: AnimatedTextKit(
                animatedTexts: [
                  TyperAnimatedText("Classification ML"),
                  TyperAnimatedText("L'IA apprend à classer les images !"),
                  TyperAnimatedText(
                    "Entraîne-la et teste ses connaissances 🚀",
                  ),
                ],
                isRepeatingAnimation: false,
              ),
            ),
          ),
        ),
        ElevatedButton(
          onPressed: skipIntro,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.buttonColor,
            foregroundColor: AppColors.buttonTextColor,
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          ),
          child: const Text("Commencer", style: TextStyle(fontSize: 16)),
        ),
        const SizedBox(height: 24),
      ],
    );
  }

  // Phase 2: Entraînement
  Widget buildTrainingPhase() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.accent.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.primary, width: 2),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "📘 Entraînement",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "L'IA apprend en observant des exemples. Clique sur les images !",
                  style: TextStyle(fontSize: 14, color: AppColors.primary),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          Text(
            "📊 Données d'entraînement :",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 10),

          ...trainingData.map((data) => buildTrainingCard(data)).toList(),

          const SizedBox(height: 20),

          Center(
            child: ElevatedButton.icon(
              onPressed: startTesting,
              icon: const Icon(Icons.quiz),
              label: const Text("Tester l'IA !"),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.secondary,
                foregroundColor: AppColors.accent,
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildTrainingCard(Map<String, dynamic> data) {
    bool isSelected = selectedImage == data["path"];
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedImage = data["path"];
          prediction = "${data['category']} ${data['icon']}";
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.accent.withOpacity(0.3) : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? AppColors.primary : Colors.grey.shade300,
            width: isSelected ? 3 : 1,
          ),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                data["path"],
                width: 80,
                height: 80,
                fit: BoxFit.cover,
                cacheWidth: 200,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${data['icon']} ${data['category']}",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    data["description"],
                    style: TextStyle(
                      fontSize: 13,
                      color: AppColors.primary.withOpacity(0.7),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Phase 3: Test
  Widget buildTestingPhase() {
    double accuracy = totalAttempts > 0
        ? (correctAnswers / totalAttempts) * 100
        : 0;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.secondary.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.secondary, width: 2),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "🎯 Test",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "Score: $correctAnswers/$totalAttempts",
                      style: TextStyle(fontSize: 16, color: AppColors.primary),
                    ),
                  ],
                ),
                if (totalAttempts > 0)
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: accuracy >= 70
                        ? AppColors.secondary
                        : Colors.orange,
                    child: Text(
                      "${accuracy.toInt()}%",
                      style: TextStyle(
                        color: AppColors.accent,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          Text(
            "Classe ces nouvelles images :",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 10),

          ...testImages.map((testData) => buildQuizCard(testData)).toList(),

          const SizedBox(height: 20),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton.icon(
                onPressed: resetQuiz,
                icon: const Icon(Icons.refresh),
                label: const Text("Réentraîner"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: AppColors.accent,
                ),
              ),
              if (totalAttempts >= testImages.length)
                ElevatedButton.icon(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text("🎉 Résultat"),
                        content: Text(
                          "Score: $correctAnswers/${testImages.length}\n"
                          "Précision: ${accuracy.toInt()}%\n\n"
                          "${accuracy >= 70 ? "Excellent ! 🌟" : "Continue ! 💪"}",
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text("OK"),
                          ),
                        ],
                      ),
                    );
                  },
                  icon: const Icon(Icons.emoji_events),
                  label: const Text("Résultat"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.secondary,
                    foregroundColor: AppColors.accent,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildQuizCard(Map<String, dynamic> testData) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                testData["path"],
                height: 150,
                width: double.infinity,
                fit: BoxFit.cover,
                cacheWidth: 400,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              "Quelle catégorie ?",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: [
                ElevatedButton(
                  onPressed: () =>
                      checkAnswer("Nature", testData["correctCategory"]),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.secondary,
                    foregroundColor: AppColors.accent,
                  ),
                  child: const Text("🌿 Nature"),
                ),
                ElevatedButton(
                  onPressed: () =>
                      checkAnswer("Déchets", testData["correctCategory"]),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.highlightColor,
                    foregroundColor: AppColors.accent,
                  ),
                  child: const Text("♻️ Déchets"),
                ),
                ElevatedButton(
                  onPressed: () =>
                      checkAnswer("Pollution", testData["correctCategory"]),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: AppColors.accent,
                  ),
                  child: const Text("🌫️ Pollution"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
