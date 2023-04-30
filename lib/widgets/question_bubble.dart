import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';

class QuestionBubble extends StatelessWidget {
  const QuestionBubble({Key? key, required this.question}) : super(key: key);
  final String question;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 8, 10, 0),
      child: Bubble(
        nip: BubbleNip.rightTop,
        padding: const BubbleEdges.all(12),
        margin: const BubbleEdges.only(top: 12),
        elevation: 0,
        alignment: Alignment.topRight,
        color: Theme.of(context)
            .colorScheme
            .primaryContainer,
        child: SelectableText(
            question,
            style: const TextStyle(fontSize: 14)),
      ),
    );
  }
}
