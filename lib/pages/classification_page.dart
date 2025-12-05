import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

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

  // Données d'entraînement avec explications
  final List<Map<String, dynamic>> trainingData = [
    {
      "path": "lib/assets/images/leaf.jpg",
      "category": "Nature",
      "icon": "🌿",
      "description": "Plantes et végétation - Bon pour l'environnement",
      "impact": "Absorbe le CO2 et produit de l'oxygène",
    },
    {
      "path": "lib/assets/images/trash.jpg",
      "category": "Déchets",
      "icon": "♻️",
      "description": "Déchets recyclables",
      "impact": "Doit être trié pour réduire la pollution",
    },
    {
      "path": "lib/assets/images/smoke.png",
      "category": "Pollution",
      "icon": "🌫️",
      "description": "Pollution industrielle",
      "impact": "Contribue au réchauffement climatique",
    },
  ];

  // Images de test pour quiz
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

  String classify(String path) {
    for (var data in trainingData) {
      if (path.contains(data["path"].split('/').last.split('.').first)) {
        return "${data['category']} ${data['icon']}";
      }
    }
    return "Catégorie inconnue";
  }

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
        title: const Text("Classification ML Supervisé"),
        backgroundColor: Colors.blue,
      ),
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
              style: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
              child: AnimatedTextKit(
                animatedTexts: [
                  TyperAnimatedText(
                    "Bienvenue dans l'apprentissage supervisé 📘 !",
                  ),
                  TyperAnimatedText(
                    "Tu vas entraîner une IA à reconnaître différentes catégories.",
                  ),
                  TyperAnimatedText(
                    "Ensuite, tu testeras ses connaissances ! 🎯",
                  ),
                ],
                isRepeatingAnimation: false,
              ),
            ),
          ),
        ),
        ElevatedButton(
          onPressed: skipIntro,
          style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
          child: const Text("Commencer l'apprentissage"),
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
          // Explication
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.blue, width: 2),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "📘 Phase d'entraînement",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                const Text(
                  "L'IA apprend en observant des exemples étiquetés. "
                  "Clique sur chaque image pour voir ce que l'IA a appris !",
                  style: TextStyle(fontSize: 14),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // Dataset d'entraînement
          const Text(
            "📊 Données d'entraînement :",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),

          ...trainingData.map((data) => buildTrainingCard(data)).toList(),

          const SizedBox(height: 20),

          // Bouton pour passer au test
          Center(
            child: ElevatedButton.icon(
              onPressed: startTesting,
              icon: const Icon(Icons.quiz),
              label: const Text("Tester l'IA maintenant !"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
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

  // Carte d'entraînement
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
          color: isSelected ? Colors.blue.shade50 : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? Colors.blue : Colors.grey.shade300,
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
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    data["description"],
                    style: TextStyle(fontSize: 13, color: Colors.grey.shade700),
                  ),
                  if (isSelected) ...[
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.green.shade100,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        "💡 ${data['impact']}",
                        style: const TextStyle(
                          fontSize: 12,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Phase 3: Test / Quiz
  Widget buildTestingPhase() {
    double accuracy = totalAttempts > 0
        ? (correctAnswers / totalAttempts) * 100
        : 0;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Score
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.green.shade50,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.green, width: 2),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "🎯 Phase de test",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "Score: $correctAnswers/$totalAttempts",
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
                if (totalAttempts > 0)
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: accuracy >= 70
                        ? Colors.green
                        : Colors.orange,
                    child: Text(
                      "${accuracy.toInt()}%",
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          const Text(
            "Aide l'IA à classifier ces nouvelles images :",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 10),

          // Quiz images
          ...testImages.map((testData) => buildQuizCard(testData)).toList(),

          const SizedBox(height: 20),

          // Boutons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton.icon(
                onPressed: resetQuiz,
                icon: const Icon(Icons.refresh),
                label: const Text("Réentraîner"),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
              ),
              if (totalAttempts >= testImages.length)
                ElevatedButton.icon(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text("🎉 Résultat final"),
                        content: Text(
                          "Score: $correctAnswers/${testImages.length}\n"
                          "Précision: ${accuracy.toInt()}%\n\n"
                          "${accuracy >= 70 ? "Excellent travail ! 🌟" : "Continue à t'entraîner ! 💪"}",
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
                  label: const Text("Voir résultat"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  // Carte de quiz
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
            const Text(
              "Cette image appartient à quelle catégorie ?",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: [
                ElevatedButton(
                  onPressed: () =>
                      checkAnswer("Nature", testData["correctCategory"]),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                  ),
                  child: const Text("🌿 Nature"),
                ),
                ElevatedButton(
                  onPressed: () =>
                      checkAnswer("Déchets", testData["correctCategory"]),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                  ),
                  child: const Text("♻️ Déchets"),
                ),
                ElevatedButton(
                  onPressed: () =>
                      checkAnswer("Pollution", testData["correctCategory"]),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
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
