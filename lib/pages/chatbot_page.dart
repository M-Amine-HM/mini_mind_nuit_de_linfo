import 'package:flutter/material.dart';
import 'package:mini_mind_nuit_de_linfo/widgets/animated_text.dart';

class ChatbotPage extends StatefulWidget {
  const ChatbotPage({super.key});

  @override
  State<ChatbotPage> createState() => _ChatbotPageState();
}

class _ChatbotPageState extends State<ChatbotPage> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, String>> messages = [];
  bool showIntro = true;

  final List<String> suggestions = [
    "Quelles actions durables puis-je faire à la maison ?",
    "Comment réduire ma consommation d'énergie ?",
    "Quels objets peuvent être recyclés ?",
  ];

  void sendMessage(String text) {
    if (text.trim().isEmpty) return;

    setState(() {
      messages.add({"sender": "user", "text": text});
      // Réponse IA prédéfinie pour prototype
      messages.add({"sender": "bot", "text": "Réponse IA : $text"});
      _controller.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Chatbot Durable 🌿")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: showIntro
            ? Column(
                children: [
                  Expanded(
                    child: Center(
                      child: AnimatedTextWidget(
                        texts: [
                          "Bienvenue dans le Chatbot Durable 🌿 !",
                          "Ce chatbot t'aide à découvrir des gestes écoresponsables et comprendre l'IA.",
                          "Il utilise des techniques NLP pour répondre à tes questions et te guider.",
                          "Clique sur 'Skip' pour commencer à discuter.",
                        ],
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () => setState(() => showIntro = false),
                    child: const Text("Skip"),
                  ),
                  const SizedBox(height: 24),
                ],
              )
            : Column(
                children: [
                  // Messages
                  Expanded(
                    child: messages.isEmpty
                        ? Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  "Suggestions :",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 16),
                                ...suggestions.map(
                                  (suggestion) => Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 8.0,
                                    ),
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        padding: const EdgeInsets.all(16),
                                      ),
                                      onPressed: () => sendMessage(suggestion),
                                      child: Text(
                                        suggestion,
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        : ListView.builder(
                            itemCount: messages.length,
                            itemBuilder: (context, index) {
                              final msg = messages[index];
                              bool isUser = msg["sender"] == "user";
                              return Align(
                                alignment: isUser
                                    ? Alignment.centerRight
                                    : Alignment.centerLeft,
                                child: Container(
                                  padding: const EdgeInsets.all(12),
                                  margin: const EdgeInsets.symmetric(
                                    vertical: 4,
                                  ),
                                  constraints: BoxConstraints(
                                    maxWidth:
                                        MediaQuery.of(context).size.width * 0.7,
                                  ),
                                  decoration: BoxDecoration(
                                    color: isUser
                                        ? Colors.blue[200]
                                        : Colors.green[200],
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: Text(msg["text"]!),
                                ),
                              );
                            },
                          ),
                  ),
                  const SizedBox(height: 8),
                  // TextField en bas
                  TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: "Écris ton message...",
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.send),
                        onPressed: () => sendMessage(_controller.text),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
