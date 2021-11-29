import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiztastic/pages/questions_screen.dart';
import 'package:quiztastic/pages/add_edit_screen.dart';
import 'package:quiztastic/repo/db/moor_database.dart';

void main() {
  runApp(Provider(
      create: (_) => MoorDatabase(),
      child: MaterialApp(initialRoute: '/', routes: {
        '/': (context) => const QuestionsListScreen(),
        '/add-edit': (context) => const AddEditScreen()
      })));
}
