import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import '../config/colors/colors.dart';

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
    {"text": "Actions durables ?", "icon": "🏠"},
    {"text": "Réduire l'énergie ?", "icon": "⚡"},
    {"text": "Le recyclage ?", "icon": "♻️"},
    {"text": "Comment l'IA marche ?", "icon": "🤖"},
  ];

  final Map<String, String> knowledgeBase = {
    "maison":
        "🏠 Actions durables à la maison :\n\n"
        "• Éteindre les lumières\n"
        "• Utiliser des ampoules LED\n"
        "• Trier les déchets\n"
        "• Composter\n"
        "• Réduire l'eau\n\n"
        "💡 Chaque geste compte !",

    "énergie":
        "⚡ Réduire l'énergie :\n\n"
        "• Appareils économes (A+++)\n"
        "• Baisser le chauffage de 1°C\n"
        "• Éteindre les veilles\n\n"
        "🌍 Économie jusqu'à 30% !",

    "recyclage":
        "♻️ Le recyclage :\n\n"
        "📦 Carton/Papier : Poubelle jaune\n"
        "🍾 Verre : Conteneur spécial\n"
        "🥤 Plastique : Poubelle jaune\n\n"
        "💚 1 tonne recyclée = 830L pétrole économisé !",

    "ia":
        "🤖 Comment fonctionne l'IA ?\n\n"
        "1️⃣ Collecte de données\n"
        "2️⃣ Apprentissage\n"
        "3️⃣ Reconnaissance de patterns\n"
        "4️⃣ Prédiction\n\n"
        "🎯 Utilisé pour : images, traduction, prédictions !",
  };

  void skipIntro() {
    if (!mounted) return;
    setState(() {
      showIntro = false;
    });
    Future.delayed(const Duration(milliseconds: 500), () {
      if (!mounted) return;
      setState(() {
        messages.add({
          "sender": "bot",
          "text":
              "👋 Salut ! Je suis ton assistant écologique.\n\n"
              "🏠 Actions durables\n"
              "⚡ Économie d'énergie\n"
              "♻️ Recyclage\n"
              "🤖 Intelligence Artificielle\n\n"
              "Pose-moi une question !",
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

    for (var entry in knowledgeBase.entries) {
      if (lowerInput.contains(entry.key)) {
        return entry.value;
      }
    }

    if (lowerInput.contains("bonjour") || lowerInput.contains("salut")) {
      return "👋 Salut ! Comment puis-je t'aider ?";
    }
    if (lowerInput.contains("merci")) {
      return "😊 Avec plaisir !";
    }

    return "🤔 Je n'ai pas encore appris ça !\n\n"
        "Essaie : actions durables, énergie, recyclage, IA";
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
        title: const Text("Chatbot Durable"),
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.accent,
      ),
      backgroundColor: AppColors.background,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: showIntro
            ? Column(
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
                            TyperAnimatedText("Chatbot Durable"),
                            TyperAnimatedText("Discute avec l'IA écologique !"),
                            TyperAnimatedText(
                              "J'utilise le NLP pour te comprendre",
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
                      padding: const EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 16,
                      ),
                    ),
                    child: const Text(
                      "Commencer",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              )
            : Column(
                children: [
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
                              backgroundColor: AppColors.accent.withOpacity(
                                0.3,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: "Écris ton message...",
                      prefixIcon: const Icon(Icons.chat_bubble_outline),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.send),
                        color: AppColors.primary,
                        onPressed: () => sendMessage(_controller.text),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      filled: true,
                      fillColor: Colors.white,
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
            Icon(Icons.chat, size: 80, color: AppColors.primary),
            const SizedBox(height: 20),
            Text(
              "💬 Pose-moi une question !",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(height: 30),
            ...suggestions.map(
              (suggestion) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(16),
                    backgroundColor: AppColors.accent.withOpacity(0.3),
                    foregroundColor: AppColors.primary,
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
          color: isUser ? AppColors.secondary : AppColors.primary,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(20),
            topRight: const Radius.circular(20),
            bottomLeft: isUser ? const Radius.circular(20) : Radius.zero,
            bottomRight: isUser ? Radius.zero : const Radius.circular(20),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              msg["text"]!,
              style: TextStyle(color: AppColors.accent, fontSize: 15),
            ),
            const SizedBox(height: 4),
            Text(
              _formatTime(msg["timestamp"]),
              style: TextStyle(
                color: AppColors.accent.withOpacity(0.7),
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
                  (index) => Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
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
