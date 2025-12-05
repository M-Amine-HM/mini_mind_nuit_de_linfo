import 'package:flutter/material.dart';

class AgriculturePage extends StatelessWidget {
  const AgriculturePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Agriculture Intelligente")),
      body: const Center(
        child: Text("Interface Chatbot IA ici", style: TextStyle(fontSize: 20)),
      ),
    );
  }
}
