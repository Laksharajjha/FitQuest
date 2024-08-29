import 'dart:convert';

class Achievement {
  final String? id;
  final String user;
  final String title;
  final String description;
  final DateTime dateEarned;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Achievement({
    this.id,
    required this.user,
    required this.title,
    required this.description,
    DateTime? dateEarned,
    this.createdAt,
    this.updatedAt,
  }) : dateEarned = dateEarned ?? DateTime.now();

  // Factory method to create an instance from JSON
  factory Achievement.fromJson(Map<String, dynamic> json) {
    return Achievement(
      id: json['_id'] as String?,
      user: json['user'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      dateEarned: DateTime.parse(json['dateEarned'] as String),
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'] as String)
          : null,
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'] as String)
          : null,
    );
  }

  // Method to convert an instance to JSON
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'user': user,
      'title': title,
      'description': description,
      'dateEarned': dateEarned.toIso8601String(),
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }
}
