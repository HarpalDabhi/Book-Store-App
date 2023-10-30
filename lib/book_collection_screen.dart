import 'package:bookstore/GradientContainer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class book_collection_screen extends StatefulWidget {
  const book_collection_screen({super.key});

  @override
  State<book_collection_screen> createState() => _book_collection_screenState();
}

class _book_collection_screenState extends State<book_collection_screen> {
  // @override
 CollectionReference collectionRef = FirebaseFirestore.instance.collection('Biography');
// QuerySnapshot querySnapshot = collectionRef.get();
// int documentCount = querySnapshot.docs.length;

  List<String> items_religious = List.generate(10, (index) => '$index');
  int itemCount_1 = 10;

  void loadMore_religious() {
    // Simulate loading more items (e.g., from an API)
    List<String> moreItems1 =
        List.generate(10, (index) => 'Item ${itemCount_1 + index}');
    setState(() {
      items_religious.addAll(moreItems1);
      itemCount_1 += moreItems1.length;
    });
  }

  List<String> items_biography = List.generate(10, (index) => '$index');
  int itemCount_2 = 10;

  void loadMore_biography() {
    // Simulate loading more items (e.g., from an API)
    List<String> moreItems2 =
        List.generate(10, (index) => 'Item ${itemCount_2 + index}');
    setState(() {
      items_biography.addAll(moreItems2);
      itemCount_2 += moreItems2.length;
    });
  }

  List<String> items_historic = List.generate(10, (index) => '$index');
  int itemCount_3 = 10;

  void loadMore_historic() {
    // Simulate loading more items (e.g., from an API)
    List<String> moreItems3 =
        List.generate(10, (index) => 'Item ${itemCount_3 + index}');
    setState(() {
      items_religious.addAll(moreItems3);
      itemCount_3 += moreItems3.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Book Collection"),
          backgroundColor: Colors.blueAccent,
          actions: [
            IconButton(
                onPressed: () {
                  print('Search');
                },
                icon: Icon(Icons.search))
          ],
        ),
        body: Stack(
          children: [
            GradientCont(),
            SingleChildScrollView(
                child: Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  SizedBox(
                    height: 10
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Biographycal Books",
                        style: TextStyle(fontSize: 25),
                      ),
                      GestureDetector(
                        onTap: () {
                          loadMore_religious();
                        },
                        child: Text(
                          "More",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                      )
                    ],
                  ),
                  Container(
                    height: 150,
                    child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('Biography')
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return CircularProgressIndicator();
                        }
                        final documents = snapshot.data!.docs;

                        return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: documents.length,
                          itemBuilder: (context, index) {
                            final document = documents[index];
                            final data = document.data();
                            return Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 4, vertical: 4),
                              child: ClipOval(
                                
                                child: Container(
                                  height: 150,width: 150,
                                color: Colors.blueAccent,
                                child: Image.network(
                                  data['Image'],fit: BoxFit.cover,
                                ),
                                // minRadius: 45,
                              ),
                              )
                            );
                          },
                        );
                      },
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Historical Books",
                        style: TextStyle(fontSize: 25),
                      ),
                      GestureDetector(
                        onTap: () {
                          loadMore_biography();
                        },
                        child: Text(
                          "More",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                      )
                    ],
                  ),
                  Container(
                    height: 150,
                    child:StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('Historical')
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return CircularProgressIndicator();
                        }
                        final documents = snapshot.data!.docs;

                        return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: documents.length,
                          itemBuilder: (context, index) {
                            final document = documents[index];
                            final data = document.data();
                            return Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 4, vertical: 4),
                              child: ClipOval(
                                
                                child: Container(
                                  height: 150,width: 150,
                                color: Colors.blueAccent,
                                child: Image.network(
                                  data['Image'],fit: BoxFit.cover,
                                ),
                                // minRadius: 45,
                              ),
                              )
                            );
                          },
                        );
                      },
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Story Books",
                        style: TextStyle(fontSize: 25),
                      ),
                      GestureDetector(
                        onTap: () {
                          loadMore_historic();
                        },
                        child: Text(
                          "More",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                      )
                    ],
                  ),
                  Container(
                    height: 150,
                    child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('Storybooks')
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return CircularProgressIndicator();
                        }
                        final documents = snapshot.data!.docs;

                        return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: documents.length,
                          itemBuilder: (context, index) {
                            final document = documents[index];
                            final data = document.data();
                            return Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 4, vertical: 4),
                              child: ClipOval(
                                
                                child: Container(
                                  height: 150,width: 150,
                                color: Colors.blueAccent,
                                child: Image.network(
                                  data['Image'],fit: BoxFit.cover,
                                ),
                                // minRadius: 45,
                              ),
                              )
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ))
          ],
        ));
  }
}
