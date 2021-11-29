import 'package:flutter/material.dart';
import 'package:quiztastic/repo/db/moor_database.dart';

class QuestionCard extends StatelessWidget {
  final Question question;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const QuestionCard({Key? key, required this.question, required this.onEdit, required this.onDelete}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: const EdgeInsets.fromLTRB(16, 16, 16, 16),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                question.questionText,
                style: const TextStyle(fontSize: 25),
              ),
              const SizedBox(height: 5),
              Text(
                '- ' + question.correctAnswer,
                style: const TextStyle(fontSize: 20),
              ),
              Text(
                '- ' + question.wrongAnswerOne,
                style: const TextStyle(fontSize: 20),
              ),
              Text(
                '- ' + question.wrongAnswerTwo,
                style: const TextStyle(fontSize: 20),
              ),
              Text(
                '- ' + question.wrongAnswerThree,
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 5),
              Text(
                'Category: ${question.category}',
                style: const TextStyle(fontSize: 15),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                TextButton.icon(
                  label: const Text('EDIT'),
                  icon: const Icon(Icons.edit),
                  onPressed: onEdit,
                ),
                TextButton.icon(
                  label: const Text('DELETE'),
                  icon: const Icon(Icons.delete),
                  onPressed: onDelete,
                ),
              ])
            ],
          ),
        ));
  }
}
