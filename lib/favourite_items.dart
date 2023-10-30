import 'package:flutter/material.dart';

class favourite_items extends StatefulWidget {
  const favourite_items({super.key});

  @override
  State<favourite_items> createState() => _favourite_itemsState();
}

class _favourite_itemsState extends State<favourite_items> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Favourites"),
      ),
    );
  }
}