import 'package:desafio_flutter/components/book_tiles.dart';
import 'package:desafio_flutter/models/book.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Body extends StatelessWidget {
  const Body({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CollectionReference home = FirebaseFirestore.instance.collection('home');

    return Center(
        child: FutureBuilder<QuerySnapshot>(
      future: home.get(),
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
    ));
  }
}
