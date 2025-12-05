import 'package:flutter/material.dart';

class ConceptPage extends StatelessWidget {
  const ConceptPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Chatbot Durable")),
      body: const Center(
        child: Text("Interface Chatbot IA ici", style: TextStyle(fontSize: 20)),
      ),
    );
  }
}
