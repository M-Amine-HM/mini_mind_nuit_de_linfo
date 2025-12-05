import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../config/colors/colors.dart';

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

        await simulateCNNProcess();

        if (!mounted) return;
        setState(() {
          showLoader = false;
          showResult = true;
          resultCategory = "Image personnalisée";
          resultText = "L'IA a analysé votre image";
        });
      }
    } catch (e) {
      debugPrint('Erreur: $e');
    }
  }

  Future<void> simulateCNNProcess() async {
    setState(() => cnnSteps = []);

    await Future.delayed(const Duration(milliseconds: 500));
    if (!mounted) return;
    setState(() {
      cnnSteps.add({
        "title": "Prétraitement",
        "description": "Ajustement de l'image",
        "icon": Icons.crop,
        "color": AppColors.primary,
        "done": true,
      });
    });

    await Future.delayed(const Duration(milliseconds: 800));
    if (!mounted) return;
    setState(() {
      cnnSteps.add({
        "title": "Convolution",
        "description": "Détection des formes",
        "icon": Icons.grid_on,
        "color": AppColors.secondary,
        "done": true,
      });
    });

    await Future.delayed(const Duration(milliseconds: 700));
    if (!mounted) return;
    setState(() {
      cnnSteps.add({
        "title": "Pooling",
        "description": "Réduction des données",
        "icon": Icons.compress,
        "color": AppColors.highlightColor,
        "done": true,
      });
    });

    await Future.delayed(const Duration(milliseconds: 1000));
    if (!mounted) return;
    setState(() {
      cnnSteps.add({
        "title": "Classification",
        "description": "Résultat final",
        "icon": Icons.psychology,
        "color": AppColors.secondary,
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

    await simulateCNNProcess();

    if (!mounted) return;
    setState(() {
      showLoader = false;
      showResult = true;
      resultCategory = imageData["category"]!;
      switch (resultCategory) {
        case "Plastique":
          resultText = "Recycler le plastique réduit la pollution";
          break;
        case "Carton":
          resultText = "Le carton recyclé préserve les arbres";
          break;
        case "Compost":
          resultText = "Le compost enrichit le sol naturellement";
          break;
        case "Électronique":
          resultText = "Recycler l'électronique évite la pollution";
          break;
        default:
          resultText = "Action durable détectée";
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
        title: const Text("Vision par ordinateur"),
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.accent,
      ),
      backgroundColor: AppColors.background,
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
                  TyperAnimatedText("Vision par ordinateur"),
                  TyperAnimatedText("L'IA reconnaît les images avec le CNN"),
                  TyperAnimatedText("Découvre comment ça marche"),
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

  Widget buildCNNExplanation() {
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
                  "Qu'est-ce qu'un CNN ?",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "Un réseau de neurones qui analyse les images",
                  style: TextStyle(fontSize: 14, color: AppColors.primary),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          buildCNNLayer(
            "Entrée",
            "L'image est divisée en pixels",
            Icons.image,
            AppColors.primary,
          ),
          Icon(Icons.arrow_downward, color: AppColors.primary.withOpacity(0.5)),
          buildCNNLayer(
            "Convolution",
            "Détection des contours et formes",
            Icons.grid_on,
            AppColors.secondary,
          ),
          Icon(Icons.arrow_downward, color: AppColors.primary.withOpacity(0.5)),
          buildCNNLayer(
            "Pooling",
            "Réduction de la taille",
            Icons.compress,
            AppColors.highlightColor,
          ),
          Icon(Icons.arrow_downward, color: AppColors.primary.withOpacity(0.5)),
          buildCNNLayer(
            "Classification",
            "Résultat final",
            Icons.psychology,
            AppColors.secondary,
          ),

          const SizedBox(height: 30),

          Center(
            child: ElevatedButton.icon(
              onPressed: startImageSelection,
              icon: const Icon(Icons.play_arrow),
              label: const Text("Tester le CNN"),
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

  Widget buildImageSelection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Choisis une image à analyser",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.primary,
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
                    border: Border.all(color: AppColors.primary, width: 2),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(14),
                    child: Image.asset(
                      img["asset"]!,
                      fit: BoxFit.cover,
                      cacheWidth: 300,
                      cacheHeight: 300,
                      errorBuilder: (context, error, stackTrace) {
                        return Center(
                          child: Icon(
                            Icons.broken_image,
                            size: 50,
                            color: AppColors.primary,
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
              backgroundColor: AppColors.secondary,
              foregroundColor: AppColors.accent,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            ),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget buildResultView() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            height: 300,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.primary, width: 3),
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

          if (showCNNProcess && cnnSteps.isNotEmpty) ...[
            Text(
              "Processus CNN",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(height: 12),
            ...cnnSteps.map((step) => buildCNNStepCard(step)).toList(),
            const SizedBox(height: 20),
          ],

          if (showLoader)
            Column(
              children: [
                SizedBox(
                  width: 60,
                  height: 60,
                  child: CircularProgressIndicator(
                    color: AppColors.primary,
                    strokeWidth: 5,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  "Analyse en cours...",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
          if (showResult)
            Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.accent.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.primary, width: 2),
                  ),
                  child: Column(
                    children: [
                      Icon(
                        Icons.check_circle,
                        color: AppColors.primary,
                        size: 48,
                      ),
                      const SizedBox(height: 12),
                      Text(
                        "Catégorie: $resultCategory",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "Confiance: 94.7%",
                        style: TextStyle(
                          fontSize: 16,
                          color: AppColors.primary.withOpacity(0.7),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        resultText,
                        style: TextStyle(
                          fontSize: 16,
                          color: AppColors.primary,
                        ),
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
                    backgroundColor: AppColors.buttonColor,
                    foregroundColor: AppColors.buttonTextColor,
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
            child: Icon(step["icon"], color: step["color"]),
          ),
          title: Text(
            step["title"],
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: AppColors.primary,
            ),
          ),
          subtitle: Text(step["description"]),
          trailing: Icon(Icons.check_circle, color: AppColors.secondary),
        ),
      ),
    );
  }
}
