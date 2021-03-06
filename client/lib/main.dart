import 'package:flutter/material.dart';

import 'package:client/widgets/post_create.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Blog App"),
      ),
      body: Column(
        children: [
          PostCreate(),
          Divider(
            indent: 20,
            endIndent: 20,
            thickness: 2,
            color: Colors.black,
          ),
        ],
      ),
    );
  }
}
