// File: lib/screens/bp_screen.dart
import 'package:flutter/material.dart';

class HeartRateScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Blood Pressure'),
      ),
      body: Center(
        child: Text('Blood Pressure Content'),
      ),
    );
  }
}
