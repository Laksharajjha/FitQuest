// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:v2/Components/home_screen/home_screen.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Profile'),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: IconButton(
            icon: SvgPicture.asset(
              'assets/vectors/logo.svg',
              width: 30,
              height: 30,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () {
                // Settings action
              },
            ),
          ],
          iconTheme: const IconThemeData(color: Colors.black),
          titleTextStyle: const TextStyle(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        body: Column(
          children: [
            const SizedBox(height: 20),
            CircleAvatar(
              radius: 50,
              backgroundColor: Colors.transparent,
              child: SvgPicture.asset(
                'assets/vectors/Profile_Pic.svg',
                width: 500,
                height: 500,
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    leading: SvgPicture.asset(
                      'assets/vectors/Profile_Pic.svg',
                      width: 40,
                      height: 40,
                    ),
                    title: Text('@user'),
                  ),
                  ListTile(
                    leading: SvgPicture.asset(
                      'assets/vectors/Gender.svg',
                      width: 40,
                      height: 40,
                    ),
                    title: Text('Female, 31 years old'),
                  ),
                  ListTile(
                    leading: SvgPicture.asset(
                      'assets/vectors/Location_house.svg',
                      width: 40,
                      height: 40,
                    ),
                    title: Text('Los Angeles, California'),
                  ),
                  ListTile(
                    leading: SvgPicture.asset(
                      'assets/vectors/Privacy.svg',
                      width: 40,
                      height: 40,
                    ),
                    title: Text('Privacy Shortcuts'),
                  ),
                  ListTile(
                    leading: SvgPicture.asset(
                      'assets/vectors/Help_Center.svg',
                      width: 40,
                      height: 40,
                    ),
                    title: Text('Help Center'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
