import 'package:desafio_flutter/auth/authentication_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            'Home',
            textAlign: TextAlign.center,
          ),
          TextButton(
            onPressed: () {
              context.read<AuthenticationService>().signOut();
            },
            child: Text('Sign Out'),
          )
        ],
      ),
    );
  }
}
