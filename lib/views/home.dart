import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:passdown/common_widget/bottom_navbar_widget.dart';
import 'package:passdown/views/upload_products.dart';

final _firestore = FirebaseFirestore.instance;
User loggedInUser;

class HomePage extends StatefulWidget {
  static const String id = 'home';
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final _auth = FirebaseAuth.instance;

  _HomePageState();

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    try {
      //final user =  _auth.currentUser;
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
    return Scaffold(
      appBar: AppBar(
        actions: <Widget> [
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                _auth.signOut();
                Navigator.pop(context);
              }),
        ],
        automaticallyImplyLeading: false,
        leading: null,
        backgroundColor: Colors.teal,
        title: Text('PASSDOWN'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, UploadProductPage.id);
        },
        child: Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavBarWidget(),
    );
  }
}


class ProductStream extends StatelessWidget {
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection('products').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.tealAccent,
            ),
          );
        }
        final products = snapshot.data.docs.reversed;
        List<Product> productItems = [];
        for (var productdata in products) {
          final passdownUser = productdata.data()['passdownUser'];
          final productnameText = productdata.data()['productnameText'];
          final descriptionText = productdata.data()['descriptionText'];
          final categoryText = productdata.data()['categoryText'];

          final currentUser = loggedInUser.email;

          final productsToDisplay = Product(
            passdownUser: passdownUser,
            productnameText: productnameText,
            descriptionText: descriptionText,
            categoryText: categoryText,
            isMe: currentUser == passdownUser,
          );

          productItems.add(productsToDisplay);
        }
        return Expanded(
          child: ListView(
            reverse: true,
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
            children: productItems,
          ),
        );
          }
          );
    }
  }


/// A single product row.
class Product extends StatelessWidget {

  Product({this.passdownUser, this.productnameText,
    this.descriptionText, this.categoryText, this.isMe});

  final String passdownUser;
  final String productnameText;
  final String categoryText;
  final String descriptionText;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(bottom: 4, top: 4),
        child: Container(
          child: Row(
            children: <Widget> [
              Text(
                productnameText,
                style: TextStyle(
                  fontSize: 12.0,
                  color: Colors.black54,
                ),
              ),
              Text(
                descriptionText,
                style: TextStyle(
                  fontSize: 12.0,
                  color: Colors.black54,
                ),
              ),
              Text(
                categoryText,
                style: TextStyle(
                  fontSize: 12.0,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ));
  }
}

