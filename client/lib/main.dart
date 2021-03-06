import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:client/widgets/post_create.dart';
import 'package:client/widgets/post.dart';

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

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List posts = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Blog App"),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  PostCreate(),
                  Divider(
                    thickness: 2,
                    color: Colors.black,
                  ),
                  Text(
                    "Posts",
                    style: TextStyle(fontSize: 30),
                  ),
                  _buildPostsList(),
                ],
              ),
            ),
    );
  }

  Widget _buildPostsList() => Expanded(
        child: ListView(
          children: posts
              .map(
                (post) => Post(
                  title: post["title"],
                  id: post["id"],
                ),
              )
              .toList(),
        ),
      );

  Future<void> fetchPosts() async {
    setState(() {
      _isLoading = true;
    });
    http.Response response;
    try {
      response = await http.get("http://10.0.2.2:4000/posts");
    } catch (e) {
      print(e);
      setState(() {
        _isLoading = false;
      });
      return;
    }

    setState(() {
      print(response.body);
      final Map<String, dynamic> responseDecoded = jsonDecode(response.body);
      posts = responseDecoded.values.toList();
      print(posts);
    });
    setState(() {
      _isLoading = false;
    });
  }
}
