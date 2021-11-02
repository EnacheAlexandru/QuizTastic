import 'package:quiztastic/domain/question_obj.dart';
import 'package:quiztastic/repo/question_repo.dart';

class QuestionService {
  final QuestionRepository _questionRepository;

  QuestionService(this._questionRepository);

  List<Question> getQuestions() {
    return _questionRepository.getQuestions();
  }

  Question getQuestionById(int? id) {
    return _questionRepository.getQuestionById(id);
  }

  void addOrUpdateQuestion(Question question) {
    return _questionRepository.addOrUpdateQuestion(question);
  }

  void deleteById(int? id) {
    return _questionRepository.deleteById(id);
  }
}