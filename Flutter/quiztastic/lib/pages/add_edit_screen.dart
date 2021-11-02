import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quiztastic/di/injection_container.dart';
import 'package:quiztastic/domain/question_obj.dart';
import 'package:quiztastic/service/question_srv.dart';

class AddEditScreen extends StatefulWidget {
  const AddEditScreen({Key? key}) : super(key: key);

  @override
  _AddEditScreenState createState() => _AddEditScreenState();
}

class _AddEditScreenState extends State<AddEditScreen> {
  Question? question;
  String _categoryValue = categories[0];
  bool _isInit = false;

  final TextEditingController _controllerQuestionText = TextEditingController();
  final TextEditingController _controllerCorrectAnswer =
      TextEditingController();
  final TextEditingController _controllerWrongAnswerOne =
      TextEditingController();
  final TextEditingController _controllerWrongAnswerTwo =
      TextEditingController();
  final TextEditingController _controllerWrongAnswerThree =
      TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();


  }

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
        appBar: AppBar(
            title: const Text('Add/Edit Question'),
            centerTitle: true,
            elevation: 0),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child:
                  Column(mainAxisAlignment: MainAxisAlignment.start, children: [
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
                      border: OutlineInputBorder(),
                      labelText: 'Question',
                      labelStyle: TextStyle(fontSize: 20)),
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
                      border: OutlineInputBorder(),
                      labelText: 'Correct Answer',
                      labelStyle: TextStyle(fontSize: 20)),
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
                      border: OutlineInputBorder(),
                      labelText: 'Wrong Answer 1',
                      labelStyle: TextStyle(fontSize: 20)),
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
                      border: OutlineInputBorder(),
                      labelText: 'Wrong Answer 2',
                      labelStyle: TextStyle(fontSize: 20)),
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
                      border: OutlineInputBorder(),
                      labelText: 'Wrong Answer 3',
                      labelStyle: TextStyle(fontSize: 20)),
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
                  items:
                      categories.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 40),
                TextButton(
                    style: TextButton.styleFrom(
                        textStyle: const TextStyle(fontSize: 50),
                        primary: Colors.white,
                        backgroundColor: Colors.lightGreen),
                    onPressed: () {
                      setState(() {
                        if (_formKey.currentState!.validate()) {
                          if (question == null) {
                            question = Question(
                                null,
                                _controllerQuestionText.text,
                                _controllerCorrectAnswer.text,
                                _controllerWrongAnswerOne.text,
                                _controllerWrongAnswerTwo.text,
                                _controllerWrongAnswerThree.text,
                                _categoryValue);
                          } else {
                            question!.questionText =
                                _controllerQuestionText.text;
                            question!.correctAnswer =
                                _controllerCorrectAnswer.text;
                            question!.wrongAnswerOne =
                                _controllerWrongAnswerOne.text;
                            question!.wrongAnswerTwo =
                                _controllerWrongAnswerTwo.text;
                            question!.wrongAnswerThree =
                                _controllerWrongAnswerThree.text;
                            question!.category = _categoryValue;
                          }
                          locator.get<QuestionService>().addOrUpdateQuestion(question!);
                          Navigator.pop(context);
                        }
                      });
                    },
                    child: const Text("Save"))
              ]),
            ),
          ),
        ));
  }
}
