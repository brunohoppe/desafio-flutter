import 'package:flutter/material.dart';

class Book {
  final String id;
  final String author;
  final String title;
  const Book({
    this.id,
    @required this.author,
    @required this.title,
  });
}
