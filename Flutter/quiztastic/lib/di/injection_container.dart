import 'package:get_it/get_it.dart';
import 'package:quiztastic/repo/question_repo.dart';
import 'package:quiztastic/service/question_srv.dart';

final locator = GetIt.instance;

void injectionSetup() {
  locator.registerLazySingleton<QuestionService>(() => QuestionService(QuestionRepository()));
}
