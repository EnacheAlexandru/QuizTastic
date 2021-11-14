import 'package:flutter/material.dart';
import 'package:quiztastic/pages/questions_screen.dart';
import 'package:quiztastic/pages/add_edit_screen.dart';
import 'di/injection_container.dart';

void main() {
  injectionSetup();
  runApp(MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => const QuestionsListScreen(),
        '/add-edit': (context) => const AddEditScreen()
      }
  ));
}