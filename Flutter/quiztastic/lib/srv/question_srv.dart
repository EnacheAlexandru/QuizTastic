import 'dart:convert';

import 'package:http/http.dart';
import 'package:moor_flutter/moor_flutter.dart';
import 'package:quiztastic/repo/db/moor_database.dart';

class QuestionService {
  MoorDatabase db;
  final String domain = "10.0.2.2:8000";
  final List<QuestionsCompanion> _questionAddedOffline = [];

  QuestionService({required this.db});

  List<QuestionsCompanion> getQuestionAddedOffline() {
    return _questionAddedOffline;
  }

  void clearQuestionAddedOffline() {
    _questionAddedOffline.clear();
  }

  void addOfflineQuestion(QuestionsCompanion question) {
    _questionAddedOffline.add(question);
    db.insertQuestion(question);
  }

  Stream<List<Question>> watchAllQuestions() async* {
    yield* db.watchAllQuestions();
  }

  Future populateLocalStorage() async {
    Response response = await get(Uri.http(domain, "/questions"));

    if (response.statusCode == 200) {
      db.deleteAllQuestions();
      Iterable iterable = jsonDecode(response.body);
      List<Question> questions = List<Question>.from(iterable.map((question) => Question.fromJson(question)));
      for (var question in questions) {
        db.insertQuestion(question);
      }
    } else {
      throw Exception('');
    }

  }

  Future deleteQuestionById(int qid) async {
    Response response = await delete(Uri.http(domain, "/questions/$qid"));

    if (response.statusCode == 200) {
      db.deleteQuestionById(qid);
    } else {
      throw Exception('');
    }
  }

  Future insertQuestion(QuestionsCompanion question) async {
    Response response = await post(Uri.http(domain, "/questions"),
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: jsonEncode({
          "questionText": question.questionText.value,
          "correctAnswer": question.correctAnswer.value,
          "wrongAnswerOne": question.wrongAnswerOne.value,
          "wrongAnswerTwo": question.wrongAnswerTwo.value,
          "wrongAnswerThree": question.wrongAnswerThree.value,
          "category": question.category.value,
        }));

    if (response.statusCode == 200) {
      Map data = jsonDecode(response.body);
      final questionToAdd = QuestionsCompanion(
          id: Value(data["id"]), // add this for error
          questionText: Value(data["questionText"]),
          correctAnswer: Value(data["correctAnswer"]),
          wrongAnswerOne: Value(data["wrongAnswerOne"]),
          wrongAnswerTwo: Value(data["wrongAnswerTwo"]),
          wrongAnswerThree: Value(data["wrongAnswerThree"]),
          category: Value(data["category"]));
      db.insertQuestion(questionToAdd);
    } else {
      throw Exception('');
    }
  }

  Future updateQuestion(Question question) async {
    Response response = await put(Uri.http(domain, "/questions"),
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: jsonEncode({
          "id": question.id,
          "questionText": question.questionText,
          "correctAnswer": question.correctAnswer,
          "wrongAnswerOne": question.wrongAnswerOne,
          "wrongAnswerTwo": question.wrongAnswerTwo,
          "wrongAnswerThree": question.wrongAnswerThree,
          "category": question.category,
        }));

    if (response.statusCode == 200) {
      db.updateQuestion(question);
    } else {
      throw Exception('');
    }
  }
}
