import 'package:desafio_flutter/components/book_tiles.dart';
import 'package:desafio_flutter/models/book.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
    return Container(
      padding: EdgeInsets.all(15),
      height: 200,
      decoration: BoxDecoration(
        color: Colors.greenAccent,
        borderRadius: BorderRadius.circular(50),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(Icons.block, size: 50.0),
          SizedBox(height: 20),
          Text(
            'Verifique seu email para acessar essa página',
          )
        ],
      ),
    );
  }

  Widget verifiedWidget() {
    CollectionReference restricted =
        FirebaseFirestore.instance.collection('restricted');

    return FutureBuilder<QuerySnapshot>(
      future: restricted.get(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data.docs.length,
              itemBuilder: (ctx, i) => BookTile(Book(
                  author: snapshot.data.docs.elementAt(i)['author'],
                  title: snapshot.data.docs.elementAt(i)['title'])),
            );
          }
        }
        return CircularProgressIndicator();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User>();
    return Center(
      child: checkEmailVerify(firebaseUser),
    );
  }
}
