import 'package:flutter/material.dart';

import 'package:client/widgets/comment_create.dart';
import 'package:client/widgets/comments_list.dart';

class Post extends StatelessWidget {
  final String title;
  final String id;
  Post({this.title, this.id});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.lightBlue[50],
        borderRadius: BorderRadius.circular(10),
      ),
      padding: EdgeInsets.all(8),
      margin: EdgeInsets.all(8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          CommentCreate(postId: id),
          CommentsList(postId: id),
        ],
      ),
    );
  }
}
