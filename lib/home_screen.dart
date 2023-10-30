import 'package:bookstore/GradientContainer.dart';
import 'package:bookstore/book_collection_screen.dart';
import 'package:bookstore/favourite_items.dart';
import 'package:bookstore/profile_screen.dart';
import 'package:bookstore/summary_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class home_screen extends StatefulWidget {
  const home_screen({super.key});

  @override
  State<home_screen> createState() => _home_screenState();
}

class _home_screenState extends State<home_screen> {
  List<Icon> icons_list = [
    Icon(
      Icons.category,
      size: 100,
      color: Colors.blue,
    ),
    Icon(
      Icons.favorite,
      size: 100,
      color: Colors.red,
    ),
    Icon(
      Icons.summarize,
      size: 100,
      color: Colors.amber,
    ),
    Icon(
      Icons.person,
      size: 100,
      color: Colors.grey,
    ),
  ];

  List<String> icons_title = ["Category", "Favourite", "Summary", "Profile"];

  List icons_screen = [
    book_collection_screen(),
    favourite_items(),
    summary_screen(),
    profile_screen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dashboard"),
        backgroundColor: Colors.blueAccent.shade200,
      ),
      body: Stack(
        children: [
          GradientCont(),
          Padding(
            padding: EdgeInsets.all(20),
            child: Column(children: [
              Expanded(
                flex: 2,
                child: Container(),
              ),
              Expanded(
                flex: 4,
                child: Container(
                  child: Column(children: [
                    Text("Welcome User",style: TextStyle(fontSize: 25),),
                    Image.asset('assets/icons/bird.png',width: 100,)
                  ],),
                  margin: EdgeInsets.only(bottom: 10),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.blueAccent.shade200,),
                ),
              ),
              Expanded(
                flex: 8,
                child: Container(
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => icons_screen[index]));
                        },
                        child: Card(
                          color: Colors.blueAccent.shade100,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              icons_list[index],
                              Text(
                                icons_title[index],
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                    itemCount: icons_list.length,
                  ),
                  width: double.infinity,
                  height: 200,
                  // color: Colors.blueAccent,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              )
            ]),
          )
        ],
      ),
    );
  }
}
