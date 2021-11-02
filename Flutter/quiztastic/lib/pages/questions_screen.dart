import 'package:flutter/material.dart';
import 'package:quiztastic/components/question_card.dart';
import 'package:quiztastic/di/injection_container.dart';
import 'package:quiztastic/domain/question_obj.dart';
import 'package:quiztastic/service/question_srv.dart';

class QuestionsListScreen extends StatefulWidget {
  const QuestionsListScreen({Key? key}) : super(key: key);

  @override
  _QuestionsListScreenState createState() => _QuestionsListScreenState();
}

class _QuestionsListScreenState extends State<QuestionsListScreen> {
  List<Question> questions = locator.get<QuestionService>().getQuestions();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('All Questions'), elevation: 0),
        body: ListView.builder(
            itemCount: questions.length,
            itemBuilder: (context, index) {
              return QuestionCard(
                  question: questions[index],
                  onEdit: () async {
                    await Navigator.pushNamed(context, '/add-edit', arguments: questions[index]);
                    setState(() {});
                  },
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
                                    onPressed: () {
                                      setState(() {
                                        locator
                                            .get<QuestionService>()
                                            .deleteById(questions[index].id);
                                      });
                                      Navigator.pop(context);
                                    },
                                    child: const Text("Yes")),
                              ])));
            }),
        backgroundColor: Colors.blue[100]);
  }
}
