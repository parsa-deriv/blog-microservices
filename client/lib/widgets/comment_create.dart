import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';

class CommentCreate extends StatefulWidget {
  final postId;
  CommentCreate({this.postId});

  @override
  _CommentCreateState createState() => _CommentCreateState();
}

class _CommentCreateState extends State<CommentCreate> {
  final _controller = TextEditingController();
  bool _isLoading = false;

  Future<void> submit() async {
    if (_controller.text == "") return;
    setState(() {
      _isLoading = true;
    });
    try {
      await http.post("http://10.0.2.2:4001/posts/${widget.postId}/comments",
          headers: {'Content-Type': "application/json; charset=UTF-8"},
          body: jsonEncode({"content": _controller.text}));
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

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextField(
          controller: _controller,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            contentPadding: EdgeInsets.symmetric(horizontal: 12),
            labelText: "New Comment",
          ),
        ),
        RaisedButton(
          child: Text("Submit"),
          color: Colors.blue,
          textColor: Colors.white,
          onPressed: _isLoading ? null : submit,
        )
      ],
    );
  }
}
