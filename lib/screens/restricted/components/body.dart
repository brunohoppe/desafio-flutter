import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

class Body extends StatelessWidget {
  const Body({
    Key key,
  }) : super(key: key);
  Widget checkEmailVerify(User firebaseUser) {
    if (!firebaseUser.emailVerified) {
      return notVerifiedWidget();
    }
    return verifiedWidget();
  }

  Widget notVerifiedWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(Icons.block, size: 50.0),
        SizedBox(height: 20),
        Text(
          'Verifique seu email para acessar essa página',
        )
      ],
    );
  }

  Widget verifiedWidget() {
    return Text('Verificado');
  }

  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User>();
    return Center(
      child: Container(
          padding: EdgeInsets.all(15),
          height: 200,
          decoration: BoxDecoration(
            color: Colors.greenAccent,
            borderRadius: BorderRadius.circular(50),
          ),
          child: checkEmailVerify(firebaseUser)),
    );
  }
}
