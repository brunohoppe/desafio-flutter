import 'package:desafio_flutter/auth/authentication_service.dart';
import 'package:desafio_flutter/screens/welcome/components/body.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  String checkEmailVerify(User firebaseUser) {
    if (!firebaseUser.emailVerified) {
      return '(Não verificado)';
    }
    return '';
  }

  Future verifyEmailDialog(User firebaseUser) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          children: <Widget>[
            SimpleDialogOption(
              onPressed: () {},
              child: ElevatedButton(
                child: Text('Validar Email'),
                onPressed: () async {
                  if (firebaseUser != null) {
                    Navigator.pop(context);
                    try {
                      await firebaseUser.sendEmailVerification();
                      final snackBar =
                          SnackBar(content: Text('Validado com sucesso'));
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      setState(() {
                        firebaseUser.reload();
                      });
                    } catch (e) {
                      final snackBar =
                          SnackBar(content: Text('Erro ao validar email'));
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                  }
                },
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User>();
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                child: Column(
                  children: <Widget>[
                    CircleAvatar(
                      child: Icon(
                        Icons.person,
                        size: 40.0,
                      ),
                    ),
                    Text(
                      '${firebaseUser.email}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                      ),
                    ),
                    Text(
                      '${checkEmailVerify(firebaseUser)}',
                      style: TextStyle(
                        color: Colors.greenAccent,
                        fontSize: 10.0,
                      ),
                    )
                  ],
                ),
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
              ),
              ListTile(
                title: Text('Meu Perfil'),
                onTap: () {},
              ),
              ListTile(
                title: Text('Validar Email'),
                onTap: () {
                  Navigator.pop(context);
                  if (!firebaseUser.emailVerified) {
                    verifyEmailDialog(firebaseUser);
                  } else {
                    final snackBar =
                        SnackBar(content: Text('Email já verificado'));
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                },
              ),
            ],
          ),
        ),
        appBar: AppBar(
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.logout),
              tooltip: 'Logout',
              onPressed: () {
                context.read<AuthenticationService>().signOut();
              },
            ),
          ],
          bottom: TabBar(
            tabs: [
              Tab(
                child: Text('Home'),
              ),
              Tab(
                child: Text('Restrito '),
              ),
            ],
          ),
        ),
        body: Body(),
      ),
    );
  }
}
