import 'package:moor_flutter/moor_flutter.dart';

part 'moor_database.g.dart';

class Questions extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get questionText => text().withLength(min: 1, max: 100)();
  TextColumn get correctAnswer => text().withLength(min: 1, max: 100)();
  TextColumn get wrongAnswerOne => text().withLength(min: 1, max: 100)();
  TextColumn get wrongAnswerTwo => text().withLength(min: 1, max: 100)();
  TextColumn get wrongAnswerThree => text().withLength(min: 1, max: 100)();
  TextColumn get category => text().withLength(min: 1, max: 30)();
}

@UseMoor(tables: [Questions])
class MoorDatabase extends _$MoorDatabase {
  MoorDatabase()
      : super((FlutterQueryExecutor.inDatabaseFolder(
            path: 'moor_quiztastic.db', logStatements: true)));

  @override
  int get schemaVersion => 1;

  Stream<List<Question>> watchAllQuestions() => select(questions).watch();
  Future<List<Question>> getAllQuestions() => select(questions).get();
  Future<Question> getQuestionById(int id) => (select(questions)..where((q) => q.id.equals(id))).getSingle();
  Future insertQuestion(Question question) => into(questions).insert(question);
  Future updateQuestion(Question question) => update(questions).replace(question);
  Future deleteQuestionById(int id) => (delete(questions)..where((q) => q.id.equals(id))).go();
}
