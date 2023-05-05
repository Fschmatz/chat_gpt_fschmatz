import 'dart:async';
import 'package:chat_gpt_fschmatz/widgets/question_bubble.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';
import '../db/question_controller.dart';
import '../db/question_dao.dart';
import '../util/app_details.dart';
import '../widgets/answer_bubble.dart';

class BookmarkedQuestions extends StatefulWidget {
  const BookmarkedQuestions({Key? key}) : super(key: key);

  @override
  _BookmarkedQuestionsState createState() => _BookmarkedQuestionsState();
}

class _BookmarkedQuestionsState extends State<BookmarkedQuestions> {
  List<Map<String, dynamic>> questions = [];
  bool loadingHistory = true;

  @override
  void initState() {
    _getBookmarks();
    super.initState();
  }

  Future<void> _getBookmarks() async {
    setState(() {
      loadingHistory = true;
    });

    final db = QuestionDao.instance;
    var resp = await db.queryAllRowsDesc();

    setState(() {
      questions = resp;
      loadingHistory = false;
    });
  }

  void _deleteQuestion(int id) async {
    deleteQuestion(id);
    _getBookmarks();
  }

  void _shareQuestion(String answer, String question) async {
    Share.share("# Question:\n$answer\n\n# Answer:\n$question");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppDetails.appName),
      ),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 600),
        child: loadingHistory
            ? const Center(child: CircularProgressIndicator())
            : ListView(
                children: [
                  ListView.separated(
                    itemCount: questions.length,
                    shrinkWrap: true,
                    physics: const ScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          QuestionBubble(
                            question: questions[index]['question'],
                          ),
                          Column(
                            children: [
                              AnswerBubble(
                                answer: questions[index]['answer'],
                                showLoadingBox: false,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  IconButton(
                                      icon: const Icon(
                                        Icons.delete_outline,
                                        size: 20,
                                      ),
                                      onPressed: () {
                                        _deleteQuestion(questions[index]['id']);
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
                                            questions[index]['question'],
                                            questions[index]['answer']);
                                      }),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      );
                    },
                    separatorBuilder: (context, index) => const Divider(),
                  ),
                  const SizedBox(
                    height: 50,
                  )
                ],
              ),
      ),
    );
  }
}
