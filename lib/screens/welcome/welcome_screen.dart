import 'package:desafio_flutter/auth/authentication_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            'Welcome',
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
