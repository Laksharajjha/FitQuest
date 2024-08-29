import 'dart:convert';

class SensorData {
  final String? id;
  final String user;
  final DateTime timestamp;
  final double? distance;
  final double? calories;
  final double? heartRate;
  final double? bodyStress;
  final SleepPatterns? sleepPatterns;
  final WorkoutDetails? workoutDetails;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  SensorData({
    this.id,
    required this.user,
    DateTime? timestamp,
    this.distance,
    this.calories,
    this.heartRate,
    this.bodyStress,
    this.sleepPatterns,
    this.workoutDetails,
    this.createdAt,
    this.updatedAt,
  }) : timestamp = timestamp ?? DateTime.now();

  // Factory method to create an instance from JSON
  factory SensorData.fromJson(Map<String, dynamic> json) {
    return SensorData(
      id: json['_id'] as String?,
      user: json['user'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
      distance: (json['distance'] as num?)?.toDouble(),
      calories: (json['calories'] as num?)?.toDouble(),
      heartRate: (json['heartRate'] as num?)?.toDouble(),
      bodyStress: (json['bodyStress'] as num?)?.toDouble(),
      sleepPatterns: json['sleepPatterns'] != null
          ? SleepPatterns.fromJson(
              json['sleepPatterns'] as Map<String, dynamic>)
          : null,
      workoutDetails: json['workoutDetails'] != null
          ? WorkoutDetails.fromJson(
              json['workoutDetails'] as Map<String, dynamic>)
          : null,
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
      'timestamp': timestamp.toIso8601String(),
      'distance': distance,
      'calories': calories,
      'heartRate': heartRate,
      'bodyStress': bodyStress,
      'sleepPatterns': sleepPatterns?.toJson(),
      'workoutDetails': workoutDetails?.toJson(),
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }
}

class SleepPatterns {
  final double? duration;
  final double? deepSleep;
  final double? lightSleep;
  final double? remSleep;

  SleepPatterns({
    this.duration,
    this.deepSleep,
    this.lightSleep,
    this.remSleep,
  });

  // Factory method to create an instance from JSON
  factory SleepPatterns.fromJson(Map<String, dynamic> json) {
    return SleepPatterns(
      duration: (json['duration'] as num?)?.toDouble(),
      deepSleep: (json['deepSleep'] as num?)?.toDouble(),
      lightSleep: (json['lightSleep'] as num?)?.toDouble(),
      remSleep: (json['remSleep'] as num?)?.toDouble(),
    );
  }

  // Method to convert an instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'duration': duration,
      'deepSleep': deepSleep,
      'lightSleep': lightSleep,
      'remSleep': remSleep,
    };
  }
}

class WorkoutDetails {
  final String? type;
  final double? duration;
  final double? caloriesBurned;

  WorkoutDetails({
    this.type,
    this.duration,
    this.caloriesBurned,
  });

  // Factory method to create an instance from JSON
  factory WorkoutDetails.fromJson(Map<String, dynamic> json) {
    return WorkoutDetails(
      type: json['type'] as String?,
      duration: (json['duration'] as num?)?.toDouble(),
      caloriesBurned: (json['caloriesBurned'] as num?)?.toDouble(),
    );
  }

  // Method to convert an instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'duration': duration,
      'caloriesBurned': caloriesBurned,
    };
  }
}
