import 'dart:async';
import 'dart:developer';

import 'package:chat_gpt_flutter/chat_gpt_flutter.dart';
import 'package:chat_gpt_fschmatz/pages/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

import '../classes/question_answer.dart';
import '../util/api_key.dart';
import '../util/app_details.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Map<String, dynamic>> history = [];
  final TextEditingController messageText = TextEditingController();

  //bool loading = true;

  String? answer;
  final chatGpt = ChatGpt(apiKey: ApiKey.key);
  bool loading = false;
  final testPrompt =
      'Which Disney character famously leaves a glass slipper behind at a royal ball?';

  final List<QuestionAnswer> questionAnswers = [];

  StreamSubscription<StreamCompletionResponse>? streamSubscription;

  @override
  void initState() {
    // messageText = TextEditingController();
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
    setState(() {
      messageText.clear();
      loading = true;
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
            } else {
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

  Future<void> sendMessage() async {
    String textToSend = messageText.text;
    messageText.text = '';

    if (textToSend.isNotEmpty) {
      String urlToSend =
          "https://joinjoaomgcd.appspot.com/_ah/api/messaging/v1/sendPush?apikey=" +
              ApiKey.key +
              "&text=" +
              textToSend +
              "&deviceId=";

      final response = await http.get(Uri.parse(urlToSend));

      if (response.body.contains('true')) {
        Fluttertoast.showToast(
          msg: "Message Sent",
        );
      }
    } else {
      Fluttertoast.showToast(
        msg: "Message is Empty",
      );
    }
  }

  void loseFocus() {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(AppDetails.appName),
          actions: [
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
                  itemCount: questionAnswers.length,
                  itemBuilder: (context, index) {
                    final questionAnswer = questionAnswers[index];
                    final answer = questionAnswer.answer.toString().trim();
                    return Card(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          ListTile(
                            contentPadding:
                            const EdgeInsets.fromLTRB(16, 8, 16, 0),
                            title: Text(questionAnswer.question),
                            onTap: () {
                              Clipboard.setData(ClipboardData(text: questionAnswer.question));
                            },
                          ),
                          Divider(color: Theme.of(context).scaffoldBackgroundColor,thickness: 2,),
                          if (answer.isEmpty && loading)
                            const Center(child: SizedBox())
                          else
                            Padding(
                              padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                              child: ListTile(
                                title: Text(answer),
                                onTap: () {
                                  Clipboard.setData(ClipboardData(text: answer));
                                },
                                contentPadding:
                                    const EdgeInsets.fromLTRB(16, 8, 16, 8),
                                tileColor: Theme.of(context)
                                    .inputDecorationTheme
                                    .fillColor,
                              ),
                            ),
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => const SizedBox(
                    height: 8,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 10, 16, 15),
                child: TextField(
                  minLines: 1,
                  maxLines: 10,
                  maxLength: 2000,
                  maxLengthEnforcement: MaxLengthEnforcement.enforced,
                  controller: messageText,
                  textCapitalization: TextCapitalization.sentences,
                  decoration: InputDecoration(
                      counterText: "",
                      hintText: "Message",
                      focusColor: Theme.of(context).colorScheme.primary,
                      suffixIcon: IconButton(
                          onPressed: () => {_sendMessage(), loseFocus()},
                          icon: Icon(
                            Icons.send_rounded,
                            color: Theme.of(context).colorScheme.primary,
                          ))),
                ),
              ),
            ],
          ),
        ));
  }
}
