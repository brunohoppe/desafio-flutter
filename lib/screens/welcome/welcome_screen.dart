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
                  Navigator.pop(context);
                  // if (firebaseUser != null) {
                  //   try {
                  //     await firebaseUser.sendEmailVerification();
                  //     final snackBar =
                  //         SnackBar(content: Text('Validado com sucesso'));
                  //     ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  //     setState(() {

                  //     });
                  //   } catch (e) {
                  //     final snackBar =
                  //         SnackBar(content: Text('Erro ao validar email'));
                  //     ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  //   }
                  // }
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
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: <Widget>[
              Container(
                height: 125.0,
                child: DrawerHeader(
                  child: null,
                  padding: EdgeInsets.zero,
                  margin: EdgeInsets.zero,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                  ),
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
          title: Wrap(
            spacing: 10.0,
            children: <Widget>[
              Text('${firebaseUser.email}'),
              Text(
                '${checkEmailVerify(firebaseUser)}',
                style: TextStyle(
                  color: Colors.greenAccent,
                  fontSize: 10.0,
                ),
              )
            ],
          ),
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
