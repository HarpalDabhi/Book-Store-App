import 'package:bookstore/GradientContainer.dart';
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
      appBar: AppBar(
        title: Text(widget.recievedData['Title']),
        backgroundColor: Colors.blueAccent,
      ),
      body: Stack(
        children: [
          GradientCont(),
          SingleChildScrollView(
            padding: EdgeInsets.all(5),
            child:
                 Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.network(
                          widget.recievedData['Image'],
                          width: 250,
                        ),
                  ]
                 ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.recievedData['Title'],
                              style: TextStyle(
                                  fontSize: 22, color: Colors.black87),
                            ),
                            Text(
                              "Author",
                              style: TextStyle(
                                  fontSize: 20, color: Colors.black54),
                            ),
                            Text(
                              widget.recievedData['Author'],
                              style: TextStyle(
                                  fontSize: 18, color: Colors.black54),
                            ),
                            Text(
                              "Language",
                              style: TextStyle(
                                  fontSize: 20, color: Colors.black54),
                            ),
                            Text(
                              widget.recievedData['Language'],
                              style: TextStyle(
                                  fontSize: 18, color: Colors.black54),
                            ),
                            Text(
                              "Price : ${widget.recievedData['Price']} Rs.",
                              style: TextStyle(
                                  fontSize: 22, color: Colors.black54),
                            ),
                            Text("Summary",style: TextStyle(fontSize: 22),),
                            Text(widget.recievedData['Summary'],)
                          ],
                        )
                  ],
                )
          )
        ],
      ),
    );
  }
}
