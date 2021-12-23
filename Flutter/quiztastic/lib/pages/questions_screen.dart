import 'dart:async';
import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';
import 'package:quiztastic/components/question_card.dart';
import 'package:quiztastic/repo/db/moor_database.dart';
import 'package:quiztastic/srv/question_srv.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class QuestionsListScreen extends StatefulWidget {
  const QuestionsListScreen({Key? key}) : super(key: key);

  @override
  _QuestionsListScreenState createState() => _QuestionsListScreenState();
}

class _QuestionsListScreenState extends State<QuestionsListScreen> {
  static final _log = Logger('QuestionsListScreen');

  final Connectivity _connectivity = Connectivity();
  ConnectivityResult _connectionStatus = ConnectivityResult.none;
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  WebSocketChannel _channel = WebSocketChannel.connect(Uri.parse('ws://10.0.2.2:8000/ws'));

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
    for (QuestionsCompanion offlineQuestion in srv.getQuestionAddedOffline()) {
      await srv.insertQuestion(offlineQuestion);
    }
    srv.clearQuestionAddedOffline();
    await srv.populateLocalStorage();
  }

  @override
  Widget build(BuildContext context) {
    final srv = Provider.of<QuestionService>(context);

    if (_connectionStatus != ConnectivityResult.none) {
      _channel = WebSocketChannel.connect(Uri.parse('ws://10.0.2.2:8000/ws'));
      _channel.stream.listen((response) {
        try {
          Map data = jsonDecode(response);
          if (data['type'] == 'add-question') {
            srv.insertQuestionBroadcast(jsonDecode(data['payload']));
          } else if (data['type'] == 'update-question') {
            srv.updateQuestionBroadcast(Question.fromJson(jsonDecode(data['payload'])));
          } else if (data['type'] == 'delete-question') {
            srv.deleteQuestionByIdBroadcast(data['payload']);
          }
        } catch (e) {
          print('Some error!');
        }
      });
    }

    return Scaffold(
        appBar: AppBar(title: const Text('All Questions'), centerTitle: true, elevation: 0),
        body: _buildQuestionList(context),
        backgroundColor: Colors.blue[100],
        floatingActionButton: FloatingActionButton(
            onPressed: () => Navigator.pushNamed(context, '/add-edit'), child: const Icon(Icons.add)));
  }

  StreamBuilder<List<Question>> _buildQuestionList(BuildContext context) {
    final srv = Provider.of<QuestionService>(context);

    try {
      _log.fine('Getting questions started...');
      if (_connectionStatus != ConnectivityResult.none) {
        populateLocalStorage(srv);
      }
      _log.fine('Success on getting questions.');
    } catch (e) {
      _log.severe('Error on getting questions. No internet.');
      Fluttertoast.showToast(msg: 'Error while trying getting questions... Offline.');
    }


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
    _channel.sink.close();
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
