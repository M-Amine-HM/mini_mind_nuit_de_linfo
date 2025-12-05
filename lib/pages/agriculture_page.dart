import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import '../config/colors/colors.dart';

class AgriculturePage extends StatefulWidget {
  const AgriculturePage({super.key});

  @override
  State<AgriculturePage> createState() => _AgriculturePageState();
}

class _AgriculturePageState extends State<AgriculturePage> {
  bool showIntro = true;
  bool showExplanation = false;
  bool showPrediction = false;

  double temperature = 20.0;
  double humidity = 50.0;
  double rainfall = 100.0;
  String soilType = "Argileux";

  String? predictedCrop;
  String? cropEmoji;
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
      steps = [
        {
          "step": "Température",
          "value": "${temperature.toInt()}°C",
          "icon": Icons.thermostat,
          "color": AppColors.primary,
        },
        {
          "step": "Humidité",
          "value": "${humidity.toInt()}%",
          "icon": Icons.water_drop,
          "color": AppColors.secondary,
        },
        {
          "step": "Précipitations",
          "value": "${rainfall.toInt()} mm",
          "icon": Icons.cloud,
          "color": AppColors.highlightColor,
        },
        {
          "step": "Type de sol",
          "value": soilType,
          "icon": Icons.grass,
          "color": AppColors.primary,
        },
      ];

      if (temperature > 25 && humidity > 60 && rainfall > 150) {
        predictedCrop = "Riz";
        cropEmoji = "🌾";
        confidence = 92.5;
      } else if (temperature < 20 && humidity < 50) {
        predictedCrop = "Blé";
        cropEmoji = "🌾";
        confidence = 88.3;
      } else if (soilType == "Sableux" && rainfall < 100) {
        predictedCrop = "Arachide";
        cropEmoji = "🥜";
        confidence = 85.0;
      } else if (temperature > 20 && rainfall > 100) {
        predictedCrop = "Maïs";
        cropEmoji = "🌽";
        confidence = 90.2;
      } else {
        predictedCrop = "Tomate";
        cropEmoji = "🍅";
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
      cropEmoji = null;
      confidence = null;
      steps = [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Prédiction Agricole"),
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.accent,
      ),
      backgroundColor: AppColors.background,
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
                  TyperAnimatedText("Prédiction Agricole"),
                  TyperAnimatedText("L'IA prédit la meilleure culture"),
                  TyperAnimatedText("Selon la météo et le sol"),
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

  Widget buildExplanation() {
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
                  "Comment ça marche ?",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "L'IA analyse plusieurs facteurs pour décider",
                  style: TextStyle(fontSize: 14, color: AppColors.primary),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          buildExplanationStep(
            "Collecte des données",
            "Température, humidité, pluie, type de sol",
            Icons.dataset,
            AppColors.primary,
          ),
          buildExplanationStep(
            "Analyse des patterns",
            "Compare avec des exemples historiques",
            Icons.analytics,
            AppColors.secondary,
          ),
          buildExplanationStep(
            "Calcul de probabilité",
            "Quelle culture a le plus de chances",
            Icons.calculate,
            AppColors.highlightColor,
          ),
          buildExplanationStep(
            "Recommandation",
            "Propose la meilleure culture",
            Icons.recommend,
            AppColors.primary,
          ),

          const SizedBox(height: 30),

          Center(
            child: ElevatedButton.icon(
              onPressed: startPrediction,
              icon: const Icon(Icons.play_arrow),
              label: const Text("Tester"),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.buttonColor,
                foregroundColor: AppColors.buttonTextColor,
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
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
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

  Widget buildPredictionInterface() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Configure ton terrain",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 20),

          buildSlider(
            label: "Température",
            value: temperature,
            min: 0,
            max: 40,
            unit: "°C",
            onChanged: (val) => setState(() => temperature = val),
          ),

          buildSlider(
            label: "Humidité",
            value: humidity,
            min: 0,
            max: 100,
            unit: "%",
            onChanged: (val) => setState(() => humidity = val),
          ),

          buildSlider(
            label: "Précipitations",
            value: rainfall,
            min: 0,
            max: 300,
            unit: "mm",
            onChanged: (val) => setState(() => rainfall = val),
          ),

          Text(
            "Type de sol",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColors.primary,
            ),
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
                selectedColor: AppColors.secondary,
                labelStyle: TextStyle(
                  color: soilType == type
                      ? AppColors.accent
                      : AppColors.primary,
                ),
              );
            }).toList(),
          ),

          const SizedBox(height: 30),

          Center(
            child: ElevatedButton.icon(
              onPressed: makePrediction,
              icon: const Icon(Icons.psychology),
              label: const Text("Prédire"),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.buttonColor,
                foregroundColor: AppColors.buttonTextColor,
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 16,
                ),
              ),
            ),
          ),

          const SizedBox(height: 30),

          if (steps.isNotEmpty) ...[
            Text(
              "Analyse en cours",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(height: 12),
            ...steps.map((step) => buildStepCard(step)).toList(),
          ],

          if (predictedCrop != null) ...[
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.secondary.withOpacity(0.2),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.primary, width: 2),
              ),
              child: Column(
                children: [
                  // Emoji grand
                  Text(cropEmoji!, style: const TextStyle(fontSize: 80)),
                  const SizedBox(height: 12),
                  Text(
                    "Culture recommandée",
                    style: TextStyle(color: AppColors.primary, fontSize: 16),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    predictedCrop!,
                    style: TextStyle(
                      color: AppColors.primary,
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
                      color: AppColors.accent,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      "Confiance: ${confidence!.toStringAsFixed(1)}%",
                      style: TextStyle(
                        color: AppColors.primary,
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
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.secondary,
                  foregroundColor: AppColors.accent,
                ),
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
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AppColors.primary,
          ),
        ),
        Slider(
          value: value,
          min: min,
          max: max,
          divisions: (max - min).toInt(),
          activeColor: AppColors.primary,
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
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: AppColors.primary,
          ),
        ),
        trailing: Text(
          step["value"],
          style: TextStyle(color: step["color"], fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
