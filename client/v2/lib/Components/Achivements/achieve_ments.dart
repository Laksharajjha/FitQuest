import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
            _buildTodayReportCards(),
          ],
        ),
      ),
    );
  }

  Widget _buildDateSelectionBar() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      color: Colors.white,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            _buildDateTile('S', '10'),
            _buildDateTile('M', '11'),
            _buildDateTile('T', '12', isSelected: true),
            _buildDateTile('W', '13'),
            _buildDateTile('T', '14'),
            _buildDateTile('F', '15'),
            _buildDateTile('S', '17'),
          ],
        ),
      ),
    );
  }

  Widget _buildDateTile(String day, String date, {bool isSelected = false}) {
    return Padding(
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
    );
  }

  Widget _buildTodayReportCards() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildCard('Active calories', '645 Cal', Colors.grey.shade200),
              _buildCard('Cycling', '', Colors.black, isMap: true),
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

  Widget _buildCard(String title, String value, Color color,
      {bool isProgress = false, bool isMap = false}) {
    return Expanded(
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
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
