import 'package:flutter/material.dart';

class MainMenuScreen extends StatelessWidget {
  const MainMenuScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text('Main Menu'), centerTitle: true, elevation: 0),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextButton.icon(
                  onPressed: () {
                    Navigator.pushNamed(context, '/questions');
                  },
                  style: TextButton.styleFrom(
                      textStyle: const TextStyle(fontSize: 40),
                      primary: Colors.white,
                      backgroundColor: Colors.blue),
                  label: const Text('All Questions'),
                  icon: const Icon(Icons.list, size: 40)
              ),
              TextButton.icon(
                  onPressed: () {
                    Navigator.pushNamed(context, '/add-edit');
                  },
                  style: TextButton.styleFrom(
                      textStyle: const TextStyle(fontSize: 40),
                      primary: Colors.white,
                      backgroundColor: Colors.blue),
                  label: const Text('Add Question'),
                  icon: const Icon(Icons.add, size: 40)
              ),
            ],
          ),
        ),
        backgroundColor: Colors.blue[100]);
  }
}
