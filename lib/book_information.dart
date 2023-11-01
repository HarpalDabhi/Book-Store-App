import 'package:flutter/material.dart';

class book_information extends StatefulWidget {
  final Map recievedData;
  const book_information({required this.recievedData});

  @override
  State<book_information> createState() => _book_informationState();
}

class _book_informationState extends State<book_information> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.recievedData['Title'])),
      backgroundColor: Colors.blueAccent,
    );
  }
}
