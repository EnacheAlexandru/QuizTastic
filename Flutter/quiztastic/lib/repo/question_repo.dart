import 'package:quiztastic/domain/question_obj.dart';

class QuestionRepository {
  int _currentId = 3;
  final List<Question> _questions = [
    Question(0, "What is the capital of Kenya?", "Nairobi", "Lusaka", "Harare",
        "Kampala", "Geography"),
    Question(
        1,
        "Which is often considered the biggest turning point of WW2?",
        "The Battle of Stalingrad",
        "The Battle of Britain",
        "The Battle of Normandy",
        "The Attack on Pearl Harbor",
        "History"),
    Question(2, "Which is the most populated city in the world?", "Tokyo",
        "New Delhi", "Beijing", "Shanghai", "Geography"),
  ];

  List<Question> getQuestions() {
    return _questions;
  }

  Question getQuestionById(int? id) {
    return _questions.firstWhere((q) => q.id == id);
  }

  void addOrUpdateQuestion(Question question) {
    if (question.id == null) {
      question.id = _currentId++;
      _questions.add(question);
    } else {
      Question questionToUpdate =
          _questions.firstWhere((q) => q.id == question.id);

      questionToUpdate.questionText = question.questionText;
      questionToUpdate.correctAnswer = question.correctAnswer;
      questionToUpdate.wrongAnswerOne = question.wrongAnswerOne;
      questionToUpdate.wrongAnswerTwo = question.wrongAnswerTwo;
      questionToUpdate.wrongAnswerThree = question.wrongAnswerThree;
      questionToUpdate.category = question.category;
    }
  }

  void deleteById(int? id) {
    _questions.removeWhere((q) => q.id == id);
  }
}
