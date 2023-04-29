import 'dart:async';
import 'package:chat_gpt_fschmatz/pages/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share/share.dart';
import '../db/question_controller.dart';
import '../db/question_dao.dart';
import '../util/app_details.dart';

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
            : ListView.separated(
                itemCount: questions.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        ListTile(
                          contentPadding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                          title: Text(questions[index]['question']),
                          onTap: () {
                            Clipboard.setData(ClipboardData(
                                text: questions[index]['question']));
                          },
                        ),
                        Divider(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          thickness: 2,
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(8, 0, 8, 2),
                          child: Column(
                            children: [
                              ListTile(
                                title: Text(questions[index]['answer']),
                                onTap: () {
                                  Clipboard.setData(ClipboardData(
                                      text: questions[index]['answer']));
                                },
                                contentPadding:
                                    const EdgeInsets.fromLTRB(16, 8, 16, 6),
                                tileColor: Theme.of(context)
                                    .inputDecorationTheme
                                    .fillColor,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  IconButton(
                                      icon: const Icon(
                                        Icons.delete_outline,
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
                                      ),
                                      onPressed: () {
                                        _shareQuestion(
                                            questions[index]['question'],//answer
                                            questions[index]['answer']);
                                      }),
                                ],
                              ),
                            ],
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
    );
  }
}