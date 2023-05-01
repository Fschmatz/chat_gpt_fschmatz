import 'dart:async';
import 'dart:developer';

import 'package:bubble/bubble.dart';
import 'package:chat_gpt_flutter/chat_gpt_flutter.dart';
import 'package:chat_gpt_fschmatz/pages/settings_page.dart';
import 'package:chat_gpt_fschmatz/util/app_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:share/share.dart';
import '../classes/question_answer.dart';
import '../db/question_controller.dart';
import '../util/api_key.dart';
import '../widgets/answer_bubble.dart';
import '../widgets/question_bubble.dart';
import 'bookmarked_questions.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Map<String, dynamic>> history = [];
  final TextEditingController messageText = TextEditingController();
  String? answer;
  final chatGpt = ChatGpt(apiKey: ApiKey.key);
  bool loading = false;
  final List<QuestionAnswer> questionAnswers = [];
  StreamSubscription<StreamCompletionResponse>? streamSubscription;
  final ScrollController _scrollController = ScrollController();
  final List<bool> showOptions = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    messageText.dispose();
    streamSubscription?.cancel();
    super.dispose();
  }

  _sendMessage() async {
    final question = messageText.text;
    if (question.isNotEmpty) {
      setState(() {
        messageText.clear();
        loading = true;
        showOptions.add(false);

        questionAnswers.add(
          QuestionAnswer(
            question: question,
            answer: StringBuffer(),
          ),
        );
      });
      final testRequest = CompletionRequest(
        stream: true,
        maxTokens: 4000,
        messages: [Message(role: Role.user.name, content: question)],
      );
      await _streamResponse(testRequest);
      setState(() => loading = false);
    } else {
      Fluttertoast.showToast(
        msg: "The message is empty.",
      );
    }
  }

  _streamResponse(CompletionRequest request) async {
    streamSubscription?.cancel();
    try {
      final stream = await chatGpt.createChatCompletionStream(request);
      streamSubscription = stream?.listen(
        (event) => setState(
          () {
            if (event.streamMessageEnd) {

              streamSubscription?.cancel();
              showOptions[questionAnswers.length - 1] = true;
              _scrollController
                  .jumpTo(_scrollController.position.maxScrollExtent + 25);

            } else {
              _scrollController
                  .jumpTo(_scrollController.position.maxScrollExtent);

              return questionAnswers.last.answer.write(
                event.choices?.first.delta?.content,
              );
            }
          },
        ),
      );
    } catch (error) {
      setState(() {
        loading = false;
        questionAnswers.last.answer.write("Error");
      });
      log("Error occurred: $error");
    }
  }

  void _saveQuestion(String question, String answer) async {
    saveQuestion(question, answer);
    Fluttertoast.showToast(
      msg: "Bookmarked question.",
    );
  }

  void _shareQuestion(String answer, String question) async {
    Share.share("# Question:\n$answer\n\n# Answer:\n$question");
  }

  void loseFocus() {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  void sendActions() {
    _sendMessage();
    loseFocus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppDetails.appName),
        actions: [
          IconButton(
              icon: const Icon(
                Icons.bookmarks_outlined,
              ),
              onPressed: () {
                loseFocus();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) =>
                          const BookmarkedQuestions(),
                    ));
              }),
          IconButton(
              icon: const Icon(
                Icons.settings_outlined,
              ),
              onPressed: () {
                loseFocus();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => SettingsPage(),
                    ));
              }),
        ],
      ),
      body: GestureDetector(
        onTap: loseFocus,
        child: Column(
          children: [
            Expanded(
              child: ListView.separated(
                controller: _scrollController,
                shrinkWrap: true,
                itemCount: questionAnswers.length,
                itemBuilder: (context, index) {

                  final questionAnswer = questionAnswers[index];
                  final answer = questionAnswer.answer.toString().trim();

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      QuestionBubble(question: questionAnswer.question),
                      if (answer.isEmpty && loading)
                        const Center(
                            child: SizedBox(
                          height: 50,
                        ))
                      else
                        Column(
                          children: [
                            AnswerBubble(answer: answer),
                            Visibility(
                              visible: showOptions[index],
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  IconButton(
                                      icon: const Icon(
                                        Icons.bookmark_outline,
                                        size: 20,
                                      ),
                                      onPressed: () {
                                        _saveQuestion(
                                            questionAnswers[index]
                                                .question
                                                .toString(),
                                            questionAnswers[index]
                                                .answer
                                                .toString());
                                      }),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  IconButton(
                                      icon: const Icon(
                                        Icons.share_outlined,
                                        size: 20,
                                      ),
                                      onPressed: () {
                                        _shareQuestion(
                                            questionAnswers[index]
                                                .question
                                                .toString(),
                                            questionAnswers[index]
                                                .answer
                                                .toString());
                                      }),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      Visibility(
                        visible: index == (questionAnswers.length - 1),
                          child: const SizedBox(height: 40,))
                    ],
                  );
                },
                separatorBuilder: (context, index) => const Divider(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: TextField(
                minLines: 1,
                maxLines: 10,
                maxLength: 1000,
                maxLengthEnforcement: MaxLengthEnforcement.enforced,
                controller: messageText,
                textCapitalization: TextCapitalization.sentences,
                textInputAction: TextInputAction.send,
                onSubmitted: (_) => {sendActions()},
                decoration: InputDecoration(
                    contentPadding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
                    counterText: "",
                    hintText: "Message",
                    focusColor: Theme.of(context).colorScheme.primary,
                    suffixIcon: IconButton(
                        onPressed: () => {sendActions()},
                        icon: Icon(
                          Icons.send_rounded,
                          color: Theme.of(context).colorScheme.primary,
                        ))),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
