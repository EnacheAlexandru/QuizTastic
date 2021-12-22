import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';
import 'package:quiztastic/pages/questions_screen.dart';
import 'package:quiztastic/pages/add_edit_screen.dart';
import 'package:quiztastic/repo/db/moor_database.dart';
import 'package:quiztastic/srv/question_srv.dart';

void main() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((record) {
    print('${record.level.name}: ${record.time}: ${record.message}');
  });

  runApp(MultiProvider(
      providers: [
        Provider(create: (_) => MoorDatabase()),
        Provider(create: (context) => QuestionService(db: Provider.of<MoorDatabase>(context, listen: false)))
      ],
      child: MaterialApp(
          initialRoute: '/',
          routes: {'/': (context) => const QuestionsListScreen(), '/add-edit': (context) => const AddEditScreen()})));
}
