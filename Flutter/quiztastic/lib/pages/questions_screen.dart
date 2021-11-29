import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:quiztastic/components/question_card.dart';
import 'package:quiztastic/repo/db/moor_database.dart';

class QuestionsListScreen extends StatefulWidget {
  const QuestionsListScreen({Key? key}) : super(key: key);

  @override
  _QuestionsListScreenState createState() => _QuestionsListScreenState();
}

class _QuestionsListScreenState extends State<QuestionsListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text('All Questions'),
            centerTitle: true,
            elevation: 0),
        body: _buildQuestionList(context),
        backgroundColor: Colors.blue[100],
        floatingActionButton: FloatingActionButton(
            onPressed: () => Navigator.pushNamed(context, '/add-edit'),
            child: const Icon(Icons.add)));
  }

  StreamBuilder<List<Question>> _buildQuestionList(BuildContext context) {
    final db = Provider.of<MoorDatabase>(context);
    return StreamBuilder(
        stream: db.watchAllQuestions(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final questions = snapshot.data ?? [];
          return ListView.builder(
              itemCount: questions.length,
              itemBuilder: (context, index) {
                return QuestionCard(
                    question: questions[index],
                    onEdit: () => Navigator.pushNamed(context, '/add-edit',
                        arguments: questions[index]),
                    onDelete: () => showDialog(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                                title: const Text("Confirm"),
                                content: const Text(
                                    "Are you sure you want to delete this question?"),
                                actions: [
                                  TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: const Text("No")),
                                  TextButton(
                                      onPressed: () async {
                                        await db
                                            .deleteQuestionById(
                                                questions[index].id)
                                            .catchError((_) =>
                                                Fluttertoast.showToast(
                                                    msg:
                                                        'Error while trying deleting...'));

                                        Navigator.pop(context);
                                      },
                                      child: const Text("Yes")),
                                ])));
              });
        });
  }
}
