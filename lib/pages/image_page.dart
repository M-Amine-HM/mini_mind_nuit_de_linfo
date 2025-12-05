import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class VisionComputerPage extends StatefulWidget {
  const VisionComputerPage({super.key});

  @override
  State<VisionComputerPage> createState() => _VisionComputerPageState();
}

class _VisionComputerPageState extends State<VisionComputerPage> {
  bool showIntro = true;
  bool showCNNExplanation = false;
  bool showImageSelection = false;
  bool showLoader = false;
  bool showResult = false;
  bool showCNNProcess = false;

  String selectedImage = '';
  File? customImage;
  String resultCategory = '';
  String resultText = '';
  List<Map<String, dynamic>> cnnSteps = [];

  final ImagePicker _picker = ImagePicker();

  final List<Map<String, String>> images = [
    {"asset": "lib/assets/images/bottle.jpg", "category": "Plastique"},
    {"asset": "lib/assets/images/carton.jpg", "category": "Carton"},
    {"asset": "lib/assets/images/apple.png", "category": "Compost"},
    {"asset": "lib/assets/images/battery.jpg", "category": "Électronique"},
  ];

  @override
  void dispose() {
    super.dispose();
  }

  void skipIntro() {
    if (!mounted) return;
    setState(() {
      showIntro = false;
      showCNNExplanation = true;
    });
  }

  void startImageSelection() {
    if (!mounted) return;
    setState(() {
      showCNNExplanation = false;
      showImageSelection = true;
    });
  }

  Future<void> pickImageFromGallery() async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 800,
        maxHeight: 800,
        imageQuality: 85,
      );

      if (pickedFile != null) {
        setState(() {
          customImage = File(pickedFile.path);
          selectedImage = '';
          showImageSelection = false;
          showLoader = true;
          showResult = false;
          showCNNProcess = true;
        });

        // Simulation du processus CNN avec étapes visibles
        await simulateCNNProcess();

        if (!mounted) return;
        setState(() {
          showLoader = false;
          showResult = true;
          resultCategory = "Image personnalisée";
          resultText =
              "L'IA a analysé votre image ! Essayez de trier correctement vos déchets 🌿";
        });
      }
    } catch (e) {
      debugPrint('Erreur lors de la sélection : $e');
    }
  }

  Future<void> simulateCNNProcess() async {
    setState(() => cnnSteps = []);

    // Étape 1: Prétraitement
    await Future.delayed(const Duration(milliseconds: 500));
    if (!mounted) return;
    setState(() {
      cnnSteps.add({
        "title": "1️⃣ Prétraitement",
        "description": "Redimensionnement et normalisation de l'image",
        "icon": Icons.crop,
        "color": Colors.blue,
        "done": true,
      });
    });

    // Étape 2: Convolution
    await Future.delayed(const Duration(milliseconds: 800));
    if (!mounted) return;
    setState(() {
      cnnSteps.add({
        "title": "2️⃣ Couches de Convolution",
        "description": "Détection des contours, textures et motifs",
        "icon": Icons.grid_on,
        "color": Colors.purple,
        "done": true,
      });
    });

    // Étape 3: Pooling
    await Future.delayed(const Duration(milliseconds: 700));
    if (!mounted) return;
    setState(() {
      cnnSteps.add({
        "title": "3️⃣ Pooling",
        "description": "Réduction de la taille des données",
        "icon": Icons.compress,
        "color": Colors.orange,
        "done": true,
      });
    });

    // Étape 4: Classification
    await Future.delayed(const Duration(milliseconds: 1000));
    if (!mounted) return;
    setState(() {
      cnnSteps.add({
        "title": "4️⃣ Réseau Dense",
        "description": "Classification finale de l'image",
        "icon": Icons.psychology,
        "color": Colors.green,
        "done": true,
      });
    });
  }

  void selectImage(Map<String, String> imageData) async {
    if (!mounted) return;
    setState(() {
      selectedImage = imageData["asset"]!;
      customImage = null;
      showImageSelection = false;
      showLoader = true;
      showResult = false;
      showCNNProcess = true;
    });

    // Simulation du processus CNN
    await simulateCNNProcess();

    if (!mounted) return;
    setState(() {
      showLoader = false;
      showResult = true;
      resultCategory = imageData["category"]!;
      switch (resultCategory) {
        case "Plastique":
          resultText =
              "Recycler une bouteille plastique permet de réduire la pollution dans les océans 🌊.";
          break;
        case "Carton":
          resultText = "Recycler le carton aide à préserver les arbres 🌳.";
          break;
        case "Compost":
          resultText = "Composter les déchets organiques enrichit le sol 🍂.";
          break;
        case "Électronique":
          resultText =
              "Recycler les appareils électroniques évite la pollution chimique ⚡.";
          break;
        default:
          resultText = "Action durable à appliquer ! 🌿";
      }
    });
  }

  void resetSelection() {
    if (!mounted) return;
    setState(() {
      selectedImage = '';
      customImage = null;
      showLoader = false;
      showResult = false;
      showImageSelection = true;
      showCNNProcess = false;
      cnnSteps = [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Vision par ordinateur CNN 🌿"),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: showIntro
            ? buildIntro()
            : showCNNExplanation
            ? buildCNNExplanation()
            : showImageSelection
            ? buildImageSelection()
            : buildResultView(),
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
                    "Bienvenue dans la Vision par ordinateur 🌿 !",
                  ),
                  TyperAnimatedText(
                    "L'IA utilise des réseaux de neurones convolutifs (CNN).",
                  ),
                  TyperAnimatedText(
                    "Découvre comment le CNN analyse les images ! 🤖",
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
          child: const Text("Découvrir le CNN"),
        ),
        const SizedBox(height: 24),
      ],
    );
  }

  // Phase 2: Explication du CNN
  Widget buildCNNExplanation() {
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
                  "🧠 Qu'est-ce qu'un CNN ?",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(
                  "Un Réseau de Neurones Convolutif (CNN) est une IA spécialisée dans l'analyse d'images.",
                  style: TextStyle(fontSize: 14),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // Architecture du CNN
          buildCNNLayer(
            "📥 Entrée - Image",
            "L'image est divisée en pixels (valeurs RGB)",
            Icons.image,
            Colors.blue,
          ),
          const Icon(Icons.arrow_downward, color: Colors.grey),
          buildCNNLayer(
            "🔍 Couches de Convolution",
            "Des filtres détectent les contours, formes et textures.\n"
                "Exemple: détection des bords d'une bouteille",
            Icons.grid_on,
            Colors.purple,
          ),
          const Icon(Icons.arrow_downward, color: Colors.grey),
          buildCNNLayer(
            "📊 Pooling (Sous-échantillonnage)",
            "Réduit la taille des données tout en gardant l'essentiel.\n"
                "Permet de réduire le temps de calcul",
            Icons.compress,
            Colors.orange,
          ),
          const Icon(Icons.arrow_downward, color: Colors.grey),
          buildCNNLayer(
            "🧮 Couches Denses",
            "Combine toutes les informations pour classifier.\n"
                "Décide si c'est du plastique, carton, etc.",
            Icons.psychology,
            Colors.green,
          ),
          const Icon(Icons.arrow_downward, color: Colors.grey),
          buildCNNLayer(
            "✅ Sortie - Prédiction",
            "Résultat final avec un pourcentage de confiance",
            Icons.check_circle,
            Colors.teal,
          ),

          const SizedBox(height: 20),

          // Info supplémentaire
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.amber.shade50,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.amber, width: 2),
            ),
            child: const Row(
              children: [
                Icon(Icons.lightbulb, color: Colors.amber, size: 40),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    "💡 Les CNN apprennent automatiquement les caractéristiques importantes d'une image, sans programmation manuelle !",
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
              onPressed: startImageSelection,
              icon: const Icon(Icons.play_arrow),
              label: const Text("Tester le CNN !"),
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

  Widget buildCNNLayer(
    String title,
    String description,
    IconData icon,
    Color color,
  ) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundColor: color.withOpacity(0.2),
              radius: 25,
              child: Icon(icon, color: color, size: 28),
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

  // Phase 3: Sélection d'image
  Widget buildImageSelection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Choisis une image pour que le CNN la classe :",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        const Text(
          "Classes disponibles : Plastique, Carton, Compost, Électronique",
          style: TextStyle(fontSize: 14, color: Colors.grey),
        ),
        const SizedBox(height: 4),
        const Text(
          "Choisis l'une de ces images ou importe ta propre image 📸",
          style: TextStyle(
            fontSize: 14,
            fontStyle: FontStyle.italic,
            color: Colors.green,
          ),
        ),
        const SizedBox(height: 16),
        Expanded(
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 1.0,
            ),
            itemCount: images.length,
            itemBuilder: (context, index) {
              final img = images[index];
              return GestureDetector(
                onTap: () => selectImage(img),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.green, width: 2),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(14),
                    child: Image.asset(
                      img["asset"]!,
                      fit: BoxFit.cover,
                      cacheWidth: 300,
                      cacheHeight: 300,
                      errorBuilder: (context, error, stackTrace) {
                        debugPrint('Error: $error');
                        return const Center(
                          child: Icon(
                            Icons.broken_image,
                            size: 50,
                            color: Colors.red,
                          ),
                        );
                      },
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 16),
        Center(
          child: ElevatedButton.icon(
            onPressed: pickImageFromGallery,
            icon: const Icon(Icons.photo_library),
            label: const Text("Importer une image"),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            ),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  // Phase 4: Vue des résultats
  Widget buildResultView() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            height: 300,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.green, width: 3),
              boxShadow: [
                BoxShadow(
                  color: Colors.green.withOpacity(0.3),
                  blurRadius: 15,
                  spreadRadius: 5,
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(13),
              child: customImage != null
                  ? Image.file(customImage!, fit: BoxFit.cover)
                  : Image.asset(
                      selectedImage,
                      fit: BoxFit.cover,
                      cacheWidth: 500,
                      cacheHeight: 500,
                    ),
            ),
          ),
          const SizedBox(height: 32),

          // Processus CNN visible
          if (showCNNProcess && cnnSteps.isNotEmpty) ...[
            const Text(
              "🔍 Processus CNN en cours :",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            ...cnnSteps.map((step) => buildCNNStepCard(step)).toList(),
            const SizedBox(height: 20),
          ],

          if (showLoader)
            const Column(
              children: [
                SizedBox(
                  width: 60,
                  height: 60,
                  child: CircularProgressIndicator(
                    color: Colors.green,
                    strokeWidth: 5,
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  "Le CNN analyse l'image...",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(
                  "Traitement des couches neuronales... 🧠",
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ],
            ),
          if (showResult)
            Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.green.shade50,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.green, width: 2),
                  ),
                  child: Column(
                    children: [
                      const Icon(
                        Icons.check_circle,
                        color: Colors.green,
                        size: 48,
                      ),
                      const SizedBox(height: 12),
                      Text(
                        "Catégorie : $resultCategory",
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        "Confiance : 94.7%",
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        resultText,
                        style: const TextStyle(fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                ElevatedButton.icon(
                  onPressed: resetSelection,
                  icon: const Icon(Icons.refresh),
                  label: const Text("Nouvelle analyse"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 16,
                    ),
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }

  Widget buildCNNStepCard(Map<String, dynamic> step) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 400),
      margin: const EdgeInsets.only(bottom: 8),
      child: Card(
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: (step["color"] as Color).withOpacity(0.2),
            child: step["done"]
                ? Icon(Icons.check, color: step["color"])
                : Icon(step["icon"], color: step["color"]),
          ),
          title: Text(
            step["title"],
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          subtitle: Text(step["description"]),
          trailing: step["done"]
              ? const Icon(Icons.check_circle, color: Colors.green)
              : const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
        ),
      ),
    );
  }
}
