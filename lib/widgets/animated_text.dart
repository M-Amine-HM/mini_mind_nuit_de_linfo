import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class AnimatedTextWidget extends StatelessWidget {
  final List<String> texts;

  const AnimatedTextWidget({super.key, required this.texts});

  @override
  Widget build(BuildContext context) {
    return AnimatedTextKit(
      isRepeatingAnimation: false,
      animatedTexts: texts
          .map(
            (text) => TypewriterAnimatedText(
              text,
              textStyle: const TextStyle(fontSize: 50),
              speed: const Duration(milliseconds: 50),
            ),
          )
          .toList(),
    );
  }
}
