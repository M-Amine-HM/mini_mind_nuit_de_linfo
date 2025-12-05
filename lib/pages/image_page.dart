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
  bool showImageSelection = false;
  bool showLoader = false;
  bool showResult = false;

  String selectedImage = '';
  File? customImage;
  String resultCategory = '';
  String resultText = '';

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
        });

        // Simulation analyse IA
        Future.delayed(const Duration(seconds: 3), () {
          if (!mounted) return;
          setState(() {
            showLoader = false;
            showResult = true;
            resultCategory = "Image personnalisée";
            resultText =
                "L'IA a analysé votre image ! Essayez de trier correctement vos déchets 🌿";
          });
        });
      }
    } catch (e) {
      debugPrint('Erreur lors de la sélection : $e');
    }
  }

  void selectImage(Map<String, String> imageData) {
    if (!mounted) return;
    setState(() {
      selectedImage = imageData["asset"]!;
      customImage = null;
      showImageSelection = false;
      showLoader = true;
      showResult = false;
    });

    Future.delayed(const Duration(seconds: 3), () {
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
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Vision par ordinateur 🌿")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: showIntro
            ? Column(
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
                              "L'IA va t'aider à classer différents objets et déchets.",
                            ),
                            TyperAnimatedText(
                              "Chaque image analysée montre comment réduire ton impact écologique.",
                            ),
                          ],
                          isRepeatingAnimation: false,
                        ),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: skipIntro,
                    child: const Text("Skip"),
                  ),
                  const SizedBox(height: 24),
                ],
              )
            : showImageSelection
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Choisis une image pour que l'IA la classe :",
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
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
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
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 16,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              )
            : SingleChildScrollView(
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
                            "L'IA analyse l'image...",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            "Réflexion en cours... 🤔",
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
                            label: const Text("Réessayer"),
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
              ),
      ),
    );
  }
}
