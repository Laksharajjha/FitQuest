import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class CommentListScreen extends StatefulWidget {
  const CommentListScreen({super.key});

  @override
  _CommentListScreenState createState() => _CommentListScreenState();
}

class _CommentListScreenState extends State<CommentListScreen> {
  late Future<List<dynamic>> futureComments;
  final TextEditingController _commentController = TextEditingController();
  String? _replyToId;
  final Dio _dio = Dio();
  final Uuid uid = const Uuid();

  @override
  void initState() {
    super.initState();
    futureComments = fetchComments();
  }

  // Fetch top-level comments dynamically from the API
  Future<List<dynamic>> fetchComments() async {
    try {
      final response = await _dio.get(
          'http://localhost:3000/v1/api/comments/comments',
          queryParameters: {
            'page': 1,
            'limit': 10,
          });
      if (response.statusCode == 200) {
        return response.data['comments'];
      } else {
        throw Exception('Failed to load comments');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  // Fetch replies for a specific comment
  Future<List<dynamic>> fetchReplies(String commentId) async {
    try {
      final response = await _dio.get(
          'http://localhost:3000/v1/api/comments/comments/$commentId/replies',
          queryParameters: {
            'page': 1,
            'limit': 10,
          });
      if (response.statusCode == 200) {
        return response.data['replies'];
      } else {
        throw Exception('Failed to load replies');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  // Post a new comment or reply to the API
  Future<void> postComment(String content, {String? parentId}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? email = prefs.getString("email");
    try {
      await _dio
          .post('http://localhost:3000/v1/api/comments/comments/$email', data: {
        'content': content,
        'parent_id': parentId,
      });
    } catch (e) {
      throw Exception('Failed to post comment');
    }
  }

  void _addComment() async {
    if (_commentController.text.isNotEmpty) {
      await postComment(_commentController.text, parentId: _replyToId);
      setState(() {
        futureComments = fetchComments(); // Refresh comments after posting
      });
      _commentController.clear();
      _replyToId = null; // Reset reply state after posting
    }
  }

  // Recursive widget to render nested replies
  Widget _buildCommentItem(dynamic comment, {int indentLevel = 0}) {
    return FutureBuilder<List<dynamic>>(
      future: fetchReplies(comment['_id']), // Fetch replies for each comment
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          final replies = snapshot.data ?? [];
          return Padding(
            padding: EdgeInsets.only(left: indentLevel * 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  title: Text(comment['content']),
                  subtitle: Text('User Email: ${comment['userId']}'),
                  trailing: IconButton(
                    icon: const Icon(Icons.reply),
                    onPressed: () {
                      setState(() {
                        _replyToId =
                            comment['_id']; // Set reply to this comment
                      });
                    },
                  ),
                ),
                // Recursively build replies
                for (var reply in replies)
                  _buildCommentItem(reply, indentLevel: indentLevel + 1),
              ],
            ),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Comments'),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder<List<dynamic>>(
              future: futureComments,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No comments available'));
                } else {
                  final comments = snapshot.data!;
                  return ListView.builder(
                    itemCount: comments.length,
                    itemBuilder: (context, index) {
                      final comment = comments[index];
                      return _buildCommentItem(comment); // Render each comment
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
                      labelText: _replyToId != null
                          ? 'Reply to comment...'
                          : 'Write a comment...',
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
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
