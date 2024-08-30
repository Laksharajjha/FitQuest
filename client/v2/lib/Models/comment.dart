import 'package:flutter/foundation.dart';

class Comment {
  final String id; // MongoDB ObjectId
  final String userId; // Reference to the User
  final String content; // Comment content
  final String? parentId; // Parent comment id (nullable)
  final DateTime createdAt; // Timestamp of creation
  final DateTime updatedAt; // Timestamp of last update
  final String v;

  Comment(
      {required this.id,
      required this.userId,
      required this.content,
      this.parentId,
      required this.createdAt,
      required this.updatedAt,
      required this.v});

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      id: json['_id'] as String,
      userId: json['userId'] as String,
      content: json['content'] as String,
      parentId: json['parent_id'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      v: json['__v'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'userId': userId,
      'content': content,
      'parent_id': parentId,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      '__v': v,
    };
  }
}
