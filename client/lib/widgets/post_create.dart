import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PostCreate extends StatefulWidget {
  @override
  _PostCreateState createState() => _PostCreateState();
}

class _PostCreateState extends State<PostCreate> {
  final _controller = TextEditingController();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Create Post",
          style: TextStyle(fontSize: 30),
        ),
        SizedBox(height: 15),
        TextField(
          controller: _controller,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            contentPadding: EdgeInsets.symmetric(horizontal: 12),
            labelText: "Title",
          ),
        ),
        SizedBox(height: 15),
        RaisedButton(
          child: Text("Submit"),
          color: Colors.blue,
          textColor: Colors.white,
          onPressed: _isLoading ? null : submit,
        )
      ],
    );
  }

  Future<void> submit() async {
    print(_controller.text.runtimeType);
    if (_controller.text == "") return;
    setState(() {
      _isLoading = true;
    });

    try {
      http.Response response = await http.post(
        "http://10.0.2.2:4000/posts",
        headers: {"Content-Type": "application/json; charset=UTF-8"},
        body: jsonEncode({"title": _controller.text}),
      );
    } catch (e) {
      print(e);
      setState(() {
        _isLoading = false;
      });
      return;
    }

    _controller.clear();
    setState(() {
      _isLoading = false;
    });
  }
}
