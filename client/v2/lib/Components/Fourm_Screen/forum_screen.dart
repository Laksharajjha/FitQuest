// lib/main.dart

import 'package:flutter/material.dart';

void main() {
  runApp(CommentApp());
}

class CommentApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Comment App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CommentListScreen(),
    );
  }
}

class CommentListScreen extends StatefulWidget {
  @override
  _CommentListScreenState createState() => _CommentListScreenState();
}

class _CommentListScreenState extends State<CommentListScreen> {
  late Future<List<Comment>> futureComments;
  final TextEditingController _commentController = TextEditingController();
  String? _replyToId;

  @override
  void initState() {
    super.initState();
    futureComments = fetchComments().then((data) {
      return data.map((json) => Comment.fromJson(json)).toList();
    });
  }

  void _addComment() async {
    if (_commentController.text.isNotEmpty) {
      await postComment(_commentController.text, parentId: _replyToId);
      setState(() {
        futureComments = fetchComments().then((data) {
          return data.map((json) => Comment.fromJson(json)).toList();
        });
      });
      _commentController.clear();
      _replyToId = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Comments'),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder<List<Comment>>(
              future: futureComments,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('No comments available'));
                } else {
                  final comments = snapshot.data!;
                  return ListView.builder(
                    itemCount: comments.length,
                    itemBuilder: (context, index) {
                      final comment = comments[index];
                      return ListTile(
                        title: Text(comment.content),
                        trailing: IconButton(
                          icon: Icon(Icons.reply),
                          onPressed: () {
                            setState(() {
                              _replyToId = comment.id;
                            });
                          },
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _commentController,
                    decoration: InputDecoration(
                      labelText: 'Write a comment...',
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: _addComment,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
