import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';
import 'package:quiztastic/components/question_card.dart';
import 'package:quiztastic/repo/db/moor_database.dart';
import 'package:quiztastic/srv/question_srv.dart';

class QuestionsListScreen extends StatefulWidget {
  const QuestionsListScreen({Key? key}) : super(key: key);

  @override
  _QuestionsListScreenState createState() => _QuestionsListScreenState();
}

class _QuestionsListScreenState extends State<QuestionsListScreen> {
  final Connectivity _connectivity = Connectivity();
  ConnectivityResult _connectionStatus = ConnectivityResult.none;
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  @override
  void initState() {
    super.initState();
    initConnectivity();

    _connectivitySubscription = _connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
      setState(() {
        _connectionStatus = result;
      });
    });

  }

  Future initConnectivity() async {
    late ConnectivityResult result;
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException {
      return;
    }

    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(result);
  }

  Future _updateConnectionStatus(ConnectivityResult result) async {
    setState(() {
      _connectionStatus = result;
    });
  }

  Future populateLocalStorage(QuestionService srv) async {
    if (_connectionStatus != ConnectivityResult.none) {
      srv.populateLocalStorage();
      for (QuestionsCompanion offlineQuestion in srv.getQuestionAddedOffline()) {
        await srv.insertQuestion(offlineQuestion);
      }
      srv.clearQuestionAddedOffline();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('All Questions'), centerTitle: true, elevation: 0),
        body: _buildQuestionList(context),
        backgroundColor: Colors.blue[100],
        floatingActionButton: FloatingActionButton(
            onPressed: () => Navigator.pushNamed(context, '/add-edit'), child: const Icon(Icons.add)));
  }

  StreamBuilder<List<Question>> _buildQuestionList(BuildContext context) {
    final srv = Provider.of<QuestionService>(context);

    populateLocalStorage(srv);

    return StreamBuilder(
        stream: srv.watchAllQuestions(),
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
                    onEdit: () => Navigator.pushNamed(context, '/add-edit', arguments: questions[index]),
                    onDelete: () => showDialog(
                        context: context,
                        builder: (BuildContext context) => AlertDialogDelete(question: questions[index])));
              });
        });
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

}

class AlertDialogDelete extends StatefulWidget {
  final Question question;

  const AlertDialogDelete({Key? key, required this.question}) : super(key: key);

  @override
  _AlertDialogDeleteState createState() => _AlertDialogDeleteState();
}

class _AlertDialogDeleteState extends State<AlertDialogDelete> {
  bool isLoading = false;
  static final _log = Logger('DeleteQuestionDialog');

  @override
  Widget build(BuildContext context) {
    final srv = Provider.of<QuestionService>(context);

    return AlertDialog(
        title: const Text("Confirm"),
        content: const Text("Are you sure you want to delete this question?"),
        actions: [
          (isLoading == true ? const SizedBox(child: CircularProgressIndicator()) : const SizedBox.shrink()),
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("No")),
          TextButton(
              onPressed: () async {
                setState(() {
                  isLoading = true;
                });
                try {
                  _log.fine('Delete started...');
                  await Future.delayed(const Duration(seconds: 2));
                  if (await Connectivity().checkConnectivity() == ConnectivityResult.none) {
                    _log.severe('Error on delete. No internet.');
                    setState(() {
                      isLoading = false;
                    });
                    Fluttertoast.showToast(msg: 'Offline...');
                    return;
                  }
                  await srv.deleteQuestionById(widget.question.id);
                  _log.fine('Success on delete.');
                  setState(() {
                    isLoading = false;
                  });
                  Navigator.pop(context);
                } catch (e) {
                  _log.severe('Error on delete.');
                  setState(() {
                    isLoading = false;
                  });
                  Fluttertoast.showToast(msg: 'Error while trying deleting...');
                }
              },
              child: const Text("Yes")),
        ]);
  }
}
