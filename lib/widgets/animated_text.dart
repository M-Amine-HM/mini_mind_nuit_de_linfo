import 'package:flutter/material.dart';

class AnimatedTextWidget extends StatefulWidget {
  final List<String> texts;

  const AnimatedTextWidget({super.key, required this.texts});

  @override
  State<AnimatedTextWidget> createState() => _AnimatedTextWidgetState();
}

class _AnimatedTextWidgetState extends State<AnimatedTextWidget> {
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    // Réinitialiser l'index à 0
    currentIndex = 0;
  }

  void _onTextComplete() {
    if (mounted && currentIndex < widget.texts.length - 1) {
      setState(() {
        currentIndex++;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return TypewriterText(
      key: ValueKey(currentIndex), // Clé pour réinitialiser l'animation
      text: widget.texts[currentIndex],
      onComplete: _onTextComplete,
    );
  }
}

class TypewriterText extends StatefulWidget {
  final String text;
  final VoidCallback? onComplete;

  const TypewriterText({super.key, required this.text, this.onComplete});

  @override
  State<TypewriterText> createState() => _TypewriterTextState();
}

class _TypewriterTextState extends State<TypewriterText>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<int> _characterCount;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: widget.text.length * 50),
      vsync: this,
    );

    _characterCount = StepTween(
      begin: 0,
      end: widget.text.length,
    ).animate(_controller);

    _controller.forward().then((_) {
      if (widget.onComplete != null) {
        Future.delayed(const Duration(seconds: 2), () {
          if (mounted) {
            widget.onComplete!();
          }
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _characterCount,
      builder: (context, child) {
        String displayText = widget.text.substring(0, _characterCount.value);
        return Text(
          displayText,
          style: const TextStyle(fontSize: 24),
          textAlign: TextAlign.center,
        );
      },
    );
  }
}
