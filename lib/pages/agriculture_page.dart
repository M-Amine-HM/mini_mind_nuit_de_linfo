import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'dart:math';

class AgriculturePage extends StatefulWidget {
  const AgriculturePage({super.key});

  @override
  State<AgriculturePage> createState() => _AgriculturePageState();
}

class _AgriculturePageState extends State<AgriculturePage> {
  bool showIntro = true;
  bool showExplanation = false;
  bool showPrediction = false;

  // Paramètres pour la prédiction
  double temperature = 20.0;
  double humidity = 50.0;
  double rainfall = 100.0;
  String soilType = "Argileux";

  String? predictedCrop;
  double? confidence;
  List<Map<String, dynamic>> steps = [];

  void skipIntro() {
    if (!mounted) return;
    setState(() {
      showIntro = false;
      showExplanation = true;
    });
  }

  void startPrediction() {
    if (!mounted) return;
    setState(() {
      showExplanation = false;
      showPrediction = true;
    });
  }

  void makePrediction() {
    setState(() {
      // Simulation du processus de décision de l'IA
      steps = [
        {
          "step": "1. Analyse de la température",
          "value": "${temperature.toInt()}°C",
          "icon": Icons.thermostat,
          "color": temperature > 25 ? Colors.orange : Colors.blue,
        },
        {
          "step": "2. Vérification de l'humidité",
          "value": "${humidity.toInt()}%",
          "icon": Icons.water_drop,
          "color": humidity > 60 ? Colors.blue : Colors.brown,
        },
        {
          "step": "3. Évaluation des précipitations",
          "value": "${rainfall.toInt()} mm",
          "icon": Icons.cloud,
          "color": rainfall > 150 ? Colors.indigo : Colors.grey,
        },
        {
          "step": "4. Type de sol",
          "value": soilType,
          "icon": Icons.grass,
          "color": Colors.green,
        },
      ];

      // Logique de prédiction simple
      if (temperature > 25 && humidity > 60 && rainfall > 150) {
        predictedCrop = "Riz 🌾";
        confidence = 92.5;
      } else if (temperature < 20 && humidity < 50) {
        predictedCrop = "Blé 🌾";
        confidence = 88.3;
      } else if (soilType == "Sableux" && rainfall < 100) {
        predictedCrop = "Arachide 🥜";
        confidence = 85.0;
      } else if (temperature > 20 && rainfall > 100) {
        predictedCrop = "Maïs 🌽";
        confidence = 90.2;
      } else {
        predictedCrop = "Tomate 🍅";
        confidence = 78.5;
      }
    });
  }

  void resetPrediction() {
    setState(() {
      temperature = 20.0;
      humidity = 50.0;
      rainfall = 100.0;
      soilType = "Argileux";
      predictedCrop = null;
      confidence = null;
      steps = [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Prédiction - Agriculture 🌾"),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: showIntro
            ? buildIntro()
            : showExplanation
            ? buildExplanation()
            : buildPredictionInterface(),
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
                color: Colors.green,
              ),
              child: AnimatedTextKit(
                animatedTexts: [
                  TyperAnimatedText(
                    "Bienvenue dans l'agriculture intelligente 🌾 !",
                  ),
                  TyperAnimatedText(
                    "L'IA va prédire la meilleure culture pour ton terrain.",
                  ),
                  TyperAnimatedText(
                    "Découvre comment l'IA analyse les données pour décider ! 🤖",
                  ),
                ],
                isRepeatingAnimation: false,
              ),
            ),
          ),
        ),
        ElevatedButton(
          onPressed: skipIntro,
          style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
          child: const Text("Découvrir comment ça marche"),
        ),
        const SizedBox(height: 24),
      ],
    );
  }

  // Phase 2: Explication du processus
  Widget buildExplanation() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Titre
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.green.shade50,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.green, width: 2),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "🤖 Comment l'IA fait-elle des prédictions ?",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(
                  "L'intelligence artificielle analyse plusieurs facteurs pour prendre une décision.",
                  style: TextStyle(fontSize: 14),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // Étapes du processus
          buildExplanationStep(
            "1️⃣ Collecte des données",
            "L'IA rassemble des informations comme la température, l'humidité, les précipitations et le type de sol.",
            Icons.dataset,
            Colors.blue,
          ),
          buildExplanationStep(
            "2️⃣ Analyse des patterns",
            "Elle compare ces données avec des milliers d'exemples historiques de cultures réussies.",
            Icons.analytics,
            Colors.purple,
          ),
          buildExplanationStep(
            "3️⃣ Calcul de probabilité",
            "L'IA calcule quelle culture a le plus de chances de réussir dans ces conditions.",
            Icons.calculate,
            Colors.orange,
          ),
          buildExplanationStep(
            "4️⃣ Recommandation",
            "Elle propose la meilleure culture avec un score de confiance (en %).",
            Icons.recommend,
            Colors.green,
          ),

          const SizedBox(height: 20),

          // Illustration
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.amber.shade50,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.amber, width: 2),
            ),
            child: Row(
              children: [
                const Icon(Icons.lightbulb, color: Colors.amber, size: 40),
                const SizedBox(width: 12),
                const Expanded(
                  child: Text(
                    "💡 L'IA ne devine pas ! Elle utilise des modèles mathématiques entraînés sur des données réelles.",
                    style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 30),

          // Bouton pour commencer
          Center(
            child: ElevatedButton.icon(
              onPressed: startPrediction,
              icon: const Icon(Icons.play_arrow),
              label: const Text("Essayer la prédiction !"),
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

  Widget buildExplanationStep(
    String title,
    String description,
    IconData icon,
    Color color,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundColor: color.withOpacity(0.2),
              child: Icon(icon, color: color),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: TextStyle(fontSize: 13, color: Colors.grey.shade700),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Phase 3: Interface de prédiction
  Widget buildPredictionInterface() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "🌾 Configure les paramètres de ton terrain :",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),

          // Température
          buildSlider(
            label: "🌡️ Température",
            value: temperature,
            min: 0,
            max: 40,
            unit: "°C",
            onChanged: (val) => setState(() => temperature = val),
          ),

          // Humidité
          buildSlider(
            label: "💧 Humidité",
            value: humidity,
            min: 0,
            max: 100,
            unit: "%",
            onChanged: (val) => setState(() => humidity = val),
          ),

          // Précipitations
          buildSlider(
            label: "☔ Précipitations annuelles",
            value: rainfall,
            min: 0,
            max: 300,
            unit: "mm",
            onChanged: (val) => setState(() => rainfall = val),
          ),

          // Type de sol
          const Text(
            "🌱 Type de sol :",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            children: ["Argileux", "Sableux", "Limoneux"].map((type) {
              return ChoiceChip(
                label: Text(type),
                selected: soilType == type,
                onSelected: (selected) {
                  if (selected) setState(() => soilType = type);
                },
                selectedColor: Colors.green,
              );
            }).toList(),
          ),

          const SizedBox(height: 30),

          // Bouton de prédiction
          Center(
            child: ElevatedButton.icon(
              onPressed: makePrediction,
              icon: const Icon(Icons.psychology),
              label: const Text("Lancer la prédiction"),
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

          const SizedBox(height: 30),

          // Affichage du processus
          if (steps.isNotEmpty) ...[
            const Text(
              "🔍 Processus de décision de l'IA :",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            ...steps.map((step) => buildStepCard(step)).toList(),
          ],

          // Résultat
          if (predictedCrop != null) ...[
            const SizedBox(height: 20),
            AnimatedContainer(
              duration: const Duration(milliseconds: 600),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.green.shade300, Colors.green.shade600],
                ),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.green.withOpacity(0.4),
                    blurRadius: 15,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Column(
                children: [
                  const Icon(Icons.check_circle, color: Colors.white, size: 60),
                  const SizedBox(height: 12),
                  const Text(
                    "Culture recommandée :",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    predictedCrop!,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      "Confiance: ${confidence!.toStringAsFixed(1)}%",
                      style: TextStyle(
                        color: Colors.green.shade700,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton.icon(
                onPressed: resetPrediction,
                icon: const Icon(Icons.refresh),
                label: const Text("Nouvelle prédiction"),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget buildSlider({
    required String label,
    required double value,
    required double min,
    required double max,
    required String unit,
    required ValueChanged<double> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "$label: ${value.toInt()} $unit",
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        Slider(
          value: value,
          min: min,
          max: max,
          divisions: (max - min).toInt(),
          activeColor: Colors.green,
          onChanged: onChanged,
        ),
        const SizedBox(height: 12),
      ],
    );
  }

  Widget buildStepCard(Map<String, dynamic> step) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: (step["color"] as Color).withOpacity(0.2),
          child: Icon(step["icon"], color: step["color"]),
        ),
        title: Text(
          step["step"],
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        trailing: Text(
          step["value"],
          style: TextStyle(color: step["color"], fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
