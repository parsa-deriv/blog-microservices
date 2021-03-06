import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';

class CommentsList extends StatefulWidget {
  final String postId;
  CommentsList({this.postId});

  @override
  _CommentsListState createState() => _CommentsListState();
}

class _CommentsListState extends State<CommentsList> {
  List comments = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchComments();
  }

  Future<void> fetchComments() async {
    setState(() {
      _isLoading = true;
    });
    http.Response response;

    try {
      response = await http
          .get("http://10.0.2.2:4001/posts/${widget.postId}/comments");
    } catch (e) {
      print(e);
      setState(() {
        _isLoading = false;
      });
    }

    final List decodedResponse =
        response == null ? [] : jsonDecode(response.body);
    print(decodedResponse);
    if (decodedResponse.isEmpty) {
      comments = [];
    } else {
      comments = decodedResponse;
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Column(
            mainAxisSize: MainAxisSize.min,
            children: comments
                .map((comment) => Text('⦿${comment["content"]}'))
                .toList(),
          );
  }
}
