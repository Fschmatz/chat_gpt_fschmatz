import 'package:chat_gpt_fschmatz/db/question_dao.dart';

void saveQuestion(String question, String answer) async {
  final db = QuestionDao.instance;
  Map<String, dynamic> row = {
    QuestionDao.columnQuestion: question,
    QuestionDao.columnAnswer: answer,
    QuestionDao.columnDate: DateTime.now().toString(),
  };
  await db.insert(row);
}

void deleteQuestion(int id) async {
  final db = QuestionDao.instance;
  await db.delete(id);
}