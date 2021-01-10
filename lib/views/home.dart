import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:passdown/common_widget/bottom_navbar_widget.dart';

final _firestore = Firestore.instance;
FirebaseUser loggedInUser;

class HomePage extends StatefulWidget {
  static const String id = 'home';
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // final List<Map> myProducts =
  //     List.generate(6, (index) => {"id": index, "name": "Product $index"})
  //         .toList();
      final _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();

    getCurrentUser();
  }

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser();
      if (user != null) {
        loggedInUser = user;
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                _auth.signOut();
                Navigator.pop(context);
              }),
        ],
        backgroundColor: Colors.teal,
        title: Text('PASSDOWN'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        // child: GridView.builder(
        //     gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        //         maxCrossAxisExtent: 200,
        //         childAspectRatio: 3 / 2,
        //         crossAxisSpacing: 20,
        //         mainAxisSpacing: 20),
        //     itemCount: myProducts.length,
        //     itemBuilder: (BuildContext context, index) {
        //       return Container(
        //         alignment: Alignment.center,
        //         child: Text(myProducts[index]["name"]),
        //         decoration: BoxDecoration(
        //           color: Colors.amber,
        //           borderRadius: BorderRadius.circular(15),
        //         ),
        //       );
        //     }),
      ),
      bottomNavigationBar: BottomNavBarWidget(),
    );
  }
}
