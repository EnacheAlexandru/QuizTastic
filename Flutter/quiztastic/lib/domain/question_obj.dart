class Question {
  int? id;
  String questionText;
  String correctAnswer;
  String wrongAnswerOne;
  String wrongAnswerTwo;
  String wrongAnswerThree;
  String category;

  Question(this.id, this.questionText, this.correctAnswer, this.wrongAnswerOne,
      this.wrongAnswerTwo, this.wrongAnswerThree, this.category);
}

List<String> categories = ['History', 'Geography', 'Math'];
