import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:logging/logging.dart';
import 'package:moor_flutter/moor_flutter.dart' hide Column;
import 'package:provider/provider.dart';
import 'package:quiztastic/repo/db/moor_database.dart';
import 'package:quiztastic/srv/question_srv.dart';

class AddEditScreen extends StatefulWidget {
  const AddEditScreen({Key? key}) : super(key: key);

  @override
  _AddEditScreenState createState() => _AddEditScreenState();
}

class _AddEditScreenState extends State<AddEditScreen> {
  static final _log = Logger('AddEditScreen');
  Question? question;
  String _categoryValue = categories[0];
  bool _isInit = false;
  bool isLoading = false;

  final TextEditingController _controllerQuestionText = TextEditingController();
  final TextEditingController _controllerCorrectAnswer = TextEditingController();
  final TextEditingController _controllerWrongAnswerOne = TextEditingController();
  final TextEditingController _controllerWrongAnswerTwo = TextEditingController();
  final TextEditingController _controllerWrongAnswerThree = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    question = ModalRoute.of(context)!.settings.arguments as Question?;

    if (_isInit == false) {
      if (question != null) {
        _controllerQuestionText.text = question!.questionText;
        _controllerCorrectAnswer.text = question!.correctAnswer;
        _controllerWrongAnswerOne.text = question!.wrongAnswerOne;
        _controllerWrongAnswerTwo.text = question!.wrongAnswerTwo;
        _controllerWrongAnswerThree.text = question!.wrongAnswerThree;
        _categoryValue = question!.category;
        _isInit = true;
      }
    }

    return Scaffold(
        backgroundColor: Colors.blue[100],
        appBar: AppBar(title: const Text('Add/Edit Question'), centerTitle: true, elevation: 0),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                const SizedBox(height: 20),
                TextFormField(
                  controller: _controllerQuestionText,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please fill this box.';
                    } else {
                      return null;
                    }
                  },
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), labelText: 'Question', labelStyle: TextStyle(fontSize: 20)),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _controllerCorrectAnswer,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please fill this box.';
                    } else {
                      return null;
                    }
                  },
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), labelText: 'Correct Answer', labelStyle: TextStyle(fontSize: 20)),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _controllerWrongAnswerOne,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please fill this box.';
                    } else {
                      return null;
                    }
                  },
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), labelText: 'Wrong Answer 1', labelStyle: TextStyle(fontSize: 20)),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _controllerWrongAnswerTwo,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please fill this box.';
                    } else {
                      return null;
                    }
                  },
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), labelText: 'Wrong Answer 2', labelStyle: TextStyle(fontSize: 20)),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _controllerWrongAnswerThree,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please fill this box.';
                    } else {
                      return null;
                    }
                  },
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), labelText: 'Wrong Answer 3', labelStyle: TextStyle(fontSize: 20)),
                ),
                const SizedBox(height: 20),
                const Text('Category', style: TextStyle(fontSize: 20)),
                DropdownButton(
                  value: _categoryValue,
                  icon: const Icon(Icons.arrow_drop_down),
                  onChanged: (String? newValue) {
                    setState(() {
                      _categoryValue = newValue!;
                    });
                  },
                  items: categories.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 10),
                (isLoading == true ? const SizedBox(child: CircularProgressIndicator()) : const SizedBox.shrink()),
                const SizedBox(height: 20),
                TextButton(
                    style: TextButton.styleFrom(
                        textStyle: const TextStyle(fontSize: 40),
                        primary: Colors.white,
                        backgroundColor: Colors.lightBlueAccent),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        final srv = Provider.of<QuestionService>(context, listen: false);
                        if (question == null) {
                          final questionToAdd = QuestionsCompanion(
                              questionText: Value(_controllerQuestionText.text),
                              correctAnswer: Value(_controllerCorrectAnswer.text),
                              wrongAnswerOne: Value(_controllerWrongAnswerOne.text),
                              wrongAnswerTwo: Value(_controllerWrongAnswerTwo.text),
                              wrongAnswerThree: Value(_controllerWrongAnswerThree.text),
                              category: Value(_categoryValue));

                          setState(() {
                            isLoading = true;
                          });
                          try {
                            _log.fine('Add started...');
                            await Future.delayed(const Duration(seconds: 2));
                            if (await Connectivity().checkConnectivity() == ConnectivityResult.none) {
                              srv.addOfflineQuestion(questionToAdd);
                              setState(() {
                                isLoading = false;
                              });
                              Fluttertoast.showToast(msg: 'Offline... Added locally.');
                              return;
                            }
                            await srv.insertQuestion(questionToAdd);
                            _log.fine('Success on add.');
                            setState(() {
                              isLoading = false;
                            });
                            Navigator.pop(context);
                          } catch (e) {
                            _log.severe('Error on add.');
                            setState(() {
                              isLoading = false;
                            });
                            Fluttertoast.showToast(msg: 'Error while trying adding...');
                          }
                        } else {
                          setState(() {
                            isLoading = true;
                          });
                          final questionToUpdate = Question(
                              id: question!.id,
                              questionText: _controllerQuestionText.text,
                              correctAnswer: _controllerCorrectAnswer.text,
                              wrongAnswerOne: _controllerWrongAnswerOne.text,
                              wrongAnswerTwo: _controllerWrongAnswerTwo.text,
                              wrongAnswerThree: _controllerWrongAnswerThree.text,
                              category: _categoryValue);

                          try {
                            _log.fine('Update started...');
                            await Future.delayed(const Duration(seconds: 2));
                            if (await Connectivity().checkConnectivity() == ConnectivityResult.none) {
                              _log.severe('Error on update. No internet.');
                              setState(() {
                                isLoading = false;
                              });
                              Fluttertoast.showToast(msg: 'Offline...');
                              return;
                            }
                            await srv.updateQuestion(questionToUpdate);
                            _log.fine('Success on update.');
                            setState(() {
                              isLoading = false;
                            });
                            Navigator.pop(context);
                          } catch (e) {
                            _log.severe('Error on update.');
                            setState(() {
                              isLoading = false;
                            });
                            Fluttertoast.showToast(msg: 'Error while trying updating...');
                          }
                        }
                      }
                    },
                    child: const Text("Save")),
              ]),
            ),
          ),
        ));
  }
}
