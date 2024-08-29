import 'dart:convert';

import 'sensor_data.dart'; // Import the SensorData model
import 'achievement.dart'; // Import the Achievement model

class User {
  final String? id;
  final String email;
  final String password;
  final List<SensorData>? data;
  final List<Achievement>? achievements;
  final String ecommerceLink;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  User({
    this.id,
    required this.email,
    required this.password,
    this.data,
    this.achievements,
    this.ecommerceLink = "",
    this.createdAt,
    this.updatedAt,
  });

  // Factory method to create an instance from JSON
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'] as String?,
      email: json['email'] as String,
      password: json['password'] as String,
      data: (json['data'] as List<dynamic>?)
          ?.map((item) => SensorData.fromJson(item as Map<String, dynamic>))
          .toList(),
      achievements: (json['achievements'] as List<dynamic>?)
          ?.map((item) => Achievement.fromJson(item as Map<String, dynamic>))
          .toList(),
      ecommerceLink: json['ecommerceLink'] as String? ?? "",
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
      'email': email,
      'password': password,
      'data': data?.map((item) => item.toJson()).toList(),
      'achievements': achievements?.map((item) => item.toJson()).toList(),
      'ecommerceLink': ecommerceLink,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }
}
