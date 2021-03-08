import 'package:flutter/material.dart';
import 'package:desafio_flutter/models/book.dart';

class BookTile extends StatelessWidget {
  final Book book;
  BookTile(this.book);
  @override
  Widget build(BuildContext context) {
    final cover = CircleAvatar(
      child: Icon(
        Icons.book,
      ),
    );
    return ListTile(
        leading: cover,
        title: Text(book.title),
        subtitle: Text(book.author),
        trailing: Container(
          width: 100,
          child: Row(
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.edit),
                color: Colors.orange,
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(Icons.delete),
                color: Colors.red,
                onPressed: () {},
              ),
            ],
          ),
        ));
  }
}
