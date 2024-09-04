import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

class AchieveMents extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          'Welcome Back !',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SvgPicture.asset('assets/vectors/logo.svg',
                height: 70, width: 40), // Add your logo here
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDateSelectionBar(),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text('Today Report',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
            _buildTodayReportCards(context),
          ],
        ),
      ),
    );
  }

  Widget _buildDateSelectionBar() {
    final today = DateTime.now();
    final startOfMonth = DateTime(today.year, today.month, 1);
    final endOfMonth = DateTime(today.year, today.month + 1, 0);

    List<Widget> dateTiles = [];
    for (var date = startOfMonth;
        date.isBefore(endOfMonth.add(Duration(days: 1)));
        date = date.add(Duration(days: 1))) {
      bool isSelected = date.day == today.day;
      dateTiles.add(_buildDateTile(
          DateFormat.E().format(date), date.day.toString(),
          isSelected: isSelected));
    }

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      color: Colors.white,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: dateTiles,
        ),
      ),
    );
  }

  Widget _buildDateTile(String day, String date, {bool isSelected = false}) {
    return GestureDetector(
      onTap: () {
        // Handle date tile tap
        print('Selected date: $day $date');
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          children: [
            Text(day),
            SizedBox(height: 4),
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isSelected ? Colors.black : Colors.greenAccent,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                date,
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.black,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTodayReportCards(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildCard('Active calories', '645 Cal', Colors.grey.shade200),
              GestureDetector(
                onTap: () {
                  _showCyclingDialog(context);
                },
                child: _buildCard('Cycling', '', Colors.black, isMap: true),
              ),
            ],
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildCard('Training time', '80%', Colors.purple.shade100,
                  isProgress: true),
              _buildCard('Steps', '999/2000', Colors.orange.shade100),
            ],
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildCard('Heart Rate', '79 Bpm', Colors.red.shade100),
              _buildCard('Keep it Up!', '', Colors.pink.shade100),
            ],
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildCard('Sleep', '', Colors.purple.shade100),
              _buildCard('Water', '6/8 Cups', Colors.blue.shade100),
            ],
          ),
        ],
      ),
    );
  }

  void _showCyclingDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Cycling Route'),
          content: Text(
              'Here would be a map or more details about the cycling route.'),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildCard(String title, String value, Color color,
      {bool isProgress = false, bool isMap = false}) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          // Handle card tap
          print('Tapped on $title card');
        },
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 8),
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              if (isProgress)
                CircularProgressIndicator(
                  value: 0.8,
                  backgroundColor: Colors.grey.shade300,
                  color: Colors.purple,
                )
              else if (isMap)
                Container(
                  height: 80,
                  color: Colors.white,
                  child: Center(
                    child: Icon(Icons.map, size: 50, color: Colors.black),
                  ),
                )
              else
                Text(value,
                    style:
                        TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ),
    );
  }
}
