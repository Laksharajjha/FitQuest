import 'package:flutter/material.dart';

class StatsCard extends StatelessWidget {
  final String title;
  final String value;
  final Widget icon; // Change from IconData to Widget
  final VoidCallback onTap;

  StatsCard({
    required this.title,
    required this.value,
    required this.icon, // Change from IconData to Widget
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: icon, // Use the Widget directly
        title: Text(title),
        subtitle: Text(value),
        onTap: onTap,
      ),
    );
  }
}
