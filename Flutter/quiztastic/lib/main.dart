import 'package:flutter/material.dart';
import 'package:quiztastic/pages/main_menu_screen.dart';
import 'package:quiztastic/pages/questions_screen.dart';
import 'package:quiztastic/pages/add_edit_screen.dart';
import 'di/injection_container.dart';

void main() {
  injectionSetup();
  runApp(MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => const MainMenuScreen(),
        '/questions': (context) => const QuestionsListScreen(),
        '/add-edit': (context) => const AddEditScreen()
      }
  ));
}