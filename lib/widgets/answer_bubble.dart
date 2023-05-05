import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';

class AnswerBubble extends StatelessWidget {
  AnswerBubble({Key? key, required this.answer, required this.showLoadingBox}) : super(key: key);
  final String answer;
  bool showLoadingBox;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
      const EdgeInsets.fromLTRB(10, 5, 10, 0),
      child: Bubble(
        padding: const BubbleEdges.all(12),
        margin: const BubbleEdges.only(top: 12),
        nip: BubbleNip.leftBottom,
        elevation: 0,
        alignment: Alignment.bottomLeft,
        color: Theme.of(context)
            .colorScheme
            .secondaryContainer,
        child: Column(
          children: [
            SelectableText(
                answer,
                style: const TextStyle(fontSize: 14)),
            Visibility(
                visible: showLoadingBox,
                child: const SizedBox(height: 25,))
          ],
        ),
      ),
    );
  }
}
