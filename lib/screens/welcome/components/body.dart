import 'package:desafio_flutter/screens/home/home_screen.dart';
import 'package:desafio_flutter/screens/restricted/restricted_screen.dart';
import 'package:flutter/material.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(
        children: [
          HomeScreen(),
          RestrictedScreen(),
        ],
      ),
    );
  }
}
