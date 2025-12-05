import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class ChatbotPage extends StatefulWidget {
  const ChatbotPage({super.key});

  @override
  State<ChatbotPage> createState() => _ChatbotPageState();
}

class _ChatbotPageState extends State<ChatbotPage> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final List<Map<String, dynamic>> messages = [];
  bool showIntro = true;
  bool isTyping = false;

  final List<Map<String, String>> suggestions = [
    {"text": "Quelles actions durables à la maison ?", "icon": "🏠"},
    {"text": "Comment réduire l'énergie ?", "icon": "⚡"},
    {"text": "Qu'est-ce que le recyclage ?", "icon": "♻️"},
    {"text": "Comment l'IA fonctionne ?", "icon": "🤖"},
  ];

  // Base de connaissances du chatbot
  final Map<String, String> knowledgeBase = {
    // Actions durables
    "maison":
        "🏠 Actions durables à la maison :\n\n"
        "• Éteindre les lumières en sortant\n"
        "• Utiliser des ampoules LED\n"
        "• Débrancher les appareils non utilisés\n"
        "• Trier ses déchets (plastique, verre, papier)\n"
        "• Composter les déchets organiques\n"
        "• Réduire la consommation d'eau\n\n"
        "💡 Chaque petit geste compte pour la planète !",

    "énergie":
        "⚡ Réduire la consommation d'énergie :\n\n"
        "• Utiliser des appareils économes (A+++)\n"
        "• Isoler correctement son logement\n"
        "• Baisser le chauffage de 1°C (7% d'économie !)\n"
        "• Privilégier les énergies renouvelables\n"
        "• Éteindre les veilles (TV, ordinateur)\n"
        "• Utiliser des multiprises avec interrupteur\n\n"
        "🌍 Tu peux économiser jusqu'à 30% d'énergie !",

    "recyclage":
        "♻️ Le recyclage expliqué :\n\n"
        "Le recyclage transforme les déchets en nouvelles ressources !\n\n"
        "📦 Carton/Papier : Poubelle jaune\n"
        "🍾 Verre : Conteneur spécial\n"
        "🥤 Plastique : Poubelle jaune (bouteilles, flacons)\n"
        "🔋 Piles/Électronique : Points de collecte\n"
        "🍂 Déchets organiques : Compost\n\n"
        "💚 1 tonne de plastique recyclé = 830L de pétrole économisé !",

    "ia":
        "🤖 Comment fonctionne l'IA ?\n\n"
        "L'Intelligence Artificielle apprend comme un humain !\n\n"
        "1️⃣ Collecte de données\n"
        "2️⃣ Apprentissage sur des exemples\n"
        "3️⃣ Reconnaissance de patterns\n"
        "4️⃣ Prédiction et décision\n\n"
        "📚 Types d'apprentissage :\n"
        "• Supervisé : avec exemples étiquetés\n"
        "• Non supervisé : trouve seul les patterns\n"
        "• Par renforcement : apprend par essai-erreur\n\n"
        "🎯 Utilisé pour : reconnaître images, traduire, prédire !",

    "pollution":
        "🌫️ Lutter contre la pollution :\n\n"
        "• Privilégier les transports en commun\n"
        "• Utiliser le vélo ou marcher\n"
        "• Covoiturer quand c'est possible\n"
        "• Éviter les produits sur-emballés\n"
        "• Acheter local et de saison\n"
        "• Réduire la consommation de viande\n\n"
        "🌱 La pollution de l'air cause 7M de décès/an dans le monde.",

    "eau":
        "💧 Économiser l'eau :\n\n"
        "• Prendre des douches courtes (5 min max)\n"
        "• Fermer le robinet en se brossant les dents\n"
        "• Installer des réducteurs de débit\n"
        "• Réparer les fuites rapidement\n"
        "• Récupérer l'eau de pluie\n"
        "• Utiliser lave-vaisselle/linge en mode éco\n\n"
        "💦 Une fuite peut gaspiller 120L d'eau par jour !",

    "plastique":
        "🥤 Réduire le plastique :\n\n"
        "• Utiliser des sacs réutilisables\n"
        "• Bouteille en inox au lieu de plastique\n"
        "• Acheter en vrac quand possible\n"
        "• Éviter les pailles et couverts jetables\n"
        "• Privilégier les emballages recyclables\n"
        "• Dire non aux sacs plastiques\n\n"
        "🌊 8M de tonnes de plastique finissent dans les océans chaque année !",

    "compost":
        "🍂 Le compostage :\n\n"
        "Le compost transforme les déchets organiques en engrais naturel !\n\n"
        "✅ Accepté : épluchures, marc de café, coquilles d'œuf, feuilles\n"
        "❌ Refusé : viande, poisson, produits laitiers, huile\n\n"
        "📊 Le compost réduit de 30% le volume des poubelles !\n"
        "🌱 Il enrichit le sol et réduit l'usage d'engrais chimiques.",
  };

  void skipIntro() {
    if (!mounted) return;
    setState(() {
      showIntro = false;
    });
    // Message de bienvenue
    Future.delayed(const Duration(milliseconds: 500), () {
      if (!mounted) return;
      setState(() {
        messages.add({
          "sender": "bot",
          "text":
              "👋 Salut ! Je suis ton assistant écologique.\n\n"
              "Je peux t'aider sur :\n"
              "🏠 Actions durables\n"
              "⚡ Économie d'énergie\n"
              "♻️ Recyclage\n"
              "🤖 Intelligence Artificielle\n\n"
              "Pose-moi une question ou clique sur une suggestion !",
          "timestamp": DateTime.now(),
        });
      });
      _scrollToBottom();
    });
  }

  void sendMessage(String text) {
    if (text.trim().isEmpty) return;

    setState(() {
      messages.add({
        "sender": "user",
        "text": text,
        "timestamp": DateTime.now(),
      });
      isTyping = true;
    });

    _scrollToBottom();

    // Simulation de délai de réponse
    Future.delayed(const Duration(seconds: 1), () {
      if (!mounted) return;
      String response = generateResponse(text);
      setState(() {
        messages.add({
          "sender": "bot",
          "text": response,
          "timestamp": DateTime.now(),
        });
        isTyping = false;
      });
      _scrollToBottom();
    });

    _controller.clear();
  }

  String generateResponse(String input) {
    String lowerInput = input.toLowerCase();

    // Recherche dans la base de connaissances
    for (var entry in knowledgeBase.entries) {
      if (lowerInput.contains(entry.key)) {
        return entry.value;
      }
    }

    // Détection de mots-clés supplémentaires
    if (lowerInput.contains("bonjour") || lowerInput.contains("salut")) {
      return "👋 Salut ! Comment puis-je t'aider aujourd'hui ?";
    }
    if (lowerInput.contains("merci")) {
      return "😊 Avec plaisir ! N'hésite pas si tu as d'autres questions.";
    }
    if (lowerInput.contains("climat") || lowerInput.contains("réchauffement")) {
      return "🌡️ Le réchauffement climatique est causé par les émissions de CO2.\n\n"
          "Tu peux agir en :\n"
          "• Réduisant ta consommation d'énergie\n"
          "• Utilisant les transports verts\n"
          "• Consommant local et de saison\n"
          "• Plantant des arbres 🌳";
    }
    if (lowerInput.contains("déchets")) {
      return knowledgeBase["recyclage"]!;
    }

    // Réponse par défaut
    return "🤔 Je n'ai pas encore appris ça !\n\n"
        "Essaie de me demander sur :\n"
        "• Les actions durables\n"
        "• L'économie d'énergie\n"
        "• Le recyclage\n"
        "• L'intelligence artificielle";
  }

  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 300), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chatbot Durable 🌿"),
        backgroundColor: Colors.green,
      ),
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
                              "Bienvenue dans le Chatbot Durable 🌿 !",
                            ),
                            TyperAnimatedText(
                              "Je vais t'aider à découvrir des gestes écoresponsables.",
                            ),
                            TyperAnimatedText(
                              "J'utilise l'IA et le NLP pour comprendre tes questions !",
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
                      backgroundColor: Colors.green,
                    ),
                    child: const Text("Commencer la discussion"),
                  ),
                  const SizedBox(height: 24),
                ],
              )
            : Column(
                children: [
                  // Messages
                  Expanded(
                    child: messages.isEmpty
                        ? buildSuggestionsView()
                        : ListView.builder(
                            controller: _scrollController,
                            itemCount: messages.length + (isTyping ? 1 : 0),
                            itemBuilder: (context, index) {
                              if (isTyping && index == messages.length) {
                                return buildTypingIndicator();
                              }
                              final msg = messages[index];
                              bool isUser = msg["sender"] == "user";
                              return buildMessageBubble(msg, isUser);
                            },
                          ),
                  ),
                  const SizedBox(height: 8),
                  // Suggestions rapides si pas de messages
                  if (messages.isNotEmpty)
                    Container(
                      height: 50,
                      margin: const EdgeInsets.only(bottom: 8),
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: suggestions.length,
                        itemBuilder: (context, index) {
                          final suggestion = suggestions[index];
                          return Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: ActionChip(
                              avatar: Text(
                                suggestion["icon"]!,
                                style: const TextStyle(fontSize: 16),
                              ),
                              label: Text(suggestion["text"]!),
                              onPressed: () => sendMessage(suggestion["text"]!),
                              backgroundColor: Colors.green.shade50,
                            ),
                          );
                        },
                      ),
                    ),
                  // TextField en bas
                  TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: "Écris ton message...",
                      prefixIcon: const Icon(Icons.chat_bubble_outline),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.send),
                        color: Colors.green,
                        onPressed: () => sendMessage(_controller.text),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      filled: true,
                      fillColor: Colors.grey.shade100,
                    ),
                    onSubmitted: sendMessage,
                  ),
                ],
              ),
      ),
    );
  }

  Widget buildSuggestionsView() {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.chat, size: 80, color: Colors.green),
            const SizedBox(height: 20),
            const Text(
              "💬 Pose-moi une question !",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),
            ...suggestions.map(
              (suggestion) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(16),
                    backgroundColor: Colors.green.shade50,
                    foregroundColor: Colors.green.shade900,
                    minimumSize: const Size(300, 50),
                  ),
                  icon: Text(
                    suggestion["icon"]!,
                    style: const TextStyle(fontSize: 24),
                  ),
                  label: Text(
                    suggestion["text"]!,
                    style: const TextStyle(fontSize: 14),
                  ),
                  onPressed: () => sendMessage(suggestion["text"]!),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildMessageBubble(Map<String, dynamic> msg, bool isUser) {
    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        margin: const EdgeInsets.symmetric(vertical: 4),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.75,
        ),
        decoration: BoxDecoration(
          gradient: isUser
              ? LinearGradient(
                  colors: [Colors.blue.shade300, Colors.blue.shade500],
                )
              : LinearGradient(
                  colors: [Colors.green.shade300, Colors.green.shade500],
                ),
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(20),
            topRight: const Radius.circular(20),
            bottomLeft: isUser ? const Radius.circular(20) : Radius.zero,
            bottomRight: isUser ? Radius.zero : const Radius.circular(20),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              msg["text"]!,
              style: const TextStyle(color: Colors.white, fontSize: 15),
            ),
            const SizedBox(height: 4),
            Text(
              _formatTime(msg["timestamp"]),
              style: TextStyle(
                color: Colors.white.withOpacity(0.7),
                fontSize: 11,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTypingIndicator() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.symmetric(vertical: 4),
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text("🤖 "),
            SizedBox(
              width: 40,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(
                  3,
                  (index) => AnimatedOpacity(
                    opacity: 1.0,
                    duration: Duration(milliseconds: 300 * (index + 1)),
                    child: Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatTime(DateTime time) {
    return "${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}";
  }
}
