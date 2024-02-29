import 'package:flutter/material.dart';
import 'package:animated_text_kit/src/animated_text.dart';

class TyperAnimatedTextCustom extends AnimatedText {
  final Duration speed;
  final Curve curve;
  final List<TextSpan> textSpans;

  TyperAnimatedTextCustom(
    this.textSpans, {
    TextAlign textAlign = TextAlign.start,
    this.speed = const Duration(milliseconds: 40),
    this.curve = Curves.linear,
  }) : super(
          text: textSpans.map((span) => span.text).join(),
          textAlign: textAlign,
          textStyle:
              TextStyle(), // Default TextStyle, individual styles are in TextSpans
          duration: speed *
              textSpans
                  .map((span) => span.text?.length ?? 0)
                  .reduce((a, b) => a + b),
        );

  late Animation<double> _typingText;

  @override
  Duration get remaining => speed * (textCharacters.length - _typingText.value);

  @override
  void initAnimation(AnimationController controller) {
    _typingText = CurveTween(curve: curve).animate(controller);
  }

  @override
  Widget animatedBuilder(BuildContext context, Widget? child) {
    final totalLength =
        textSpans.map((span) => span.text?.length ?? 0).reduce((a, b) => a + b);
    final count = (_typingText.value.clamp(0, 1) * totalLength).round();

    int currentCount = 0;
    List<TextSpan> currentSpans = [];

    for (var span in textSpans) {
      int spanLength = span.text?.length ?? 0;
      int remaining = count - currentCount;
      if (remaining <= 0) break;

      String currentText = span.text
              ?.substring(0, remaining > spanLength ? spanLength : remaining) ??
          '';
      currentSpans.add(TextSpan(text: currentText, style: span.style));

      currentCount += spanLength;
    }

    return RichText(
      text: TextSpan(children: currentSpans),
      textAlign: textAlign,
    );
  }

  @override
  Widget completeText(BuildContext context) {
    return RichText(
      text: TextSpan(children: textSpans),
      textAlign: textAlign,
    );
  }
}

// // Usage Example
// TyperAnimatedTextCustom(
//   [
//     TextSpan(text: "Hello ", style: TextStyle(color: Colors.red)),
//     TextSpan(text: "World", style: TextStyle(color: Colors.blue)),
//   ],
//   // Other properties...
// )
