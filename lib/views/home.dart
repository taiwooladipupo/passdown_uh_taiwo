import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:passdown/common_widget/bottom_navbar_widget.dart';
import 'package:passdown/common_widget/search_widget.dart';

FirebaseUser loggedInUser;

class HomePage extends StatefulWidget {
  static const String id = 'home';
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  String productname = 'product_name';
  String description = 'description';
  String imageurl;
  String _categorySort = 'sort category';

  _HomePageState();


  final _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();

    getCurrentUser();
  }

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
  Query query =
  FirebaseFirestore.instance.collection('passdownapp');

  void _onActionSelected(String value) async {
    if (value == "products") {
      WriteBatch batch = FirebaseFirestore.instance.batch();

      await query.get().then((querySnapshot) async {
        querySnapshot.docs.forEach((document) {
          batch.update(document.reference, {'products': 0});
        });

        await batch.commit();

        setState(() {
          _categorySort = "sort_category";
        });
      });
    } else {
      setState(() {
        _categorySort = value;
      });
    }
  }

  switch (_categorySort) {
    case "sort_category":
      query = query.orderBy('category', descending: true);
      break;

    case "sort_clothing_desc":
      query = query.orderBy('clothing', descending: true);
      break;

    case "sort_clothing_asc":
      query = query.orderBy('clothing', descending: false);
      break;

    case "sort_fooditems_desc":
      query = query.orderBy('fooditems', descending: true);
      break;

    case "sort_fooditems_asc":
      query = query.orderBy('fooditems', descending: false);
      break;

    case "sort_schoolitems_desc":
      query = query.orderBy('schoolitems', descending: true);
      break;

    case "sort_schoolitems_asc":
      query = query.orderBy('schoolitems', descending: false);
      break;
  }


  return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: null,
        actions: <Widget>[
          PopupMenuButton(
            onSelected: (String value) async {
              await _onActionSelected(value);
            },
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem(
                  value: "sort_category",
                  child: Text("Sort by Category"),
                ),
                PopupMenuItem(
                  value: "sort_clothing_desc",
                  child: Text("Sort by Clothing descending"),
                ),
                PopupMenuItem(
                  value: "sort_clothing_asc",
                  child: Text("Sort by Clothing ascending"),
                ),
                PopupMenuItem(
                  value: "sort_fooditems_desc",
                  child: Text("Sort by Likes descending"),
                ),
                PopupMenuItem(
                  value: "sort_fooditems_asc",
                  child: Text("Sort by Clothing ascending"),
                ),
                PopupMenuItem(
                  value: "sort_schoolitems_desc",
                  child: Text("Sort by School Items descending"),
                ),
                PopupMenuItem(
                  value: "sort_schoolitems_asc",
                  child: Text("Sort by School Items ascending"),
                ),
              ];
            },
          ),
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          StreamBuilder<QuerySnapshot>(
                  stream: query.snapshots(),
                  builder: (context, stream) {
                    if (stream.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }

                    if (stream.hasError) {
                      return Center(child: Text(stream.error.toString()));
                    }

                    QuerySnapshot querySnapshot = stream.data;

                    return ListView.builder(
                      itemCount: querySnapshot.size,
                      itemBuilder: (context, index) => Product(querySnapshot.docs[index]),
                    );
                  },
                ),
        ],
      ),
    bottomNavigationBar: BottomNavBarWidget(),
  );
  }
}
