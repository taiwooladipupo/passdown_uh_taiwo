import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:passdown/common_widget/bottom_navbar_widget.dart';
import 'package:passdown/views/home.dart';
import 'package:passdown/views/product.dart';

final _firestore = FirebaseFirestore.instance;
User loggedInUser;

class UploadProductPage extends StatefulWidget {
  static const String id = 'upload_product';
  @override
  _UploadProductPageState createState() => _UploadProductPageState();
}

class _UploadProductPageState extends State<UploadProductPage> {

  final _auth = FirebaseAuth.instance;
  bool showSpinner = false;

  final productTextController = TextEditingController();
  final descriptionTextController = TextEditingController();
  final categoryTextController = TextEditingController();
  //TODO: Image File Controller
  String productName;
  String description;
  String image;
  String category;

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
        backgroundColor: Colors.teal,
        title: Text('UPLOAD YOUR GIFT'),
      ),
      body: Column(
        children: [
          TextField(
            textAlign: TextAlign.left,
            controller: productTextController,
            onChanged: (value) {
              productName = value;
            },
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              labelText: "Name of Gift Item",
            ),
          ),
          TextField(
            textAlign: TextAlign.left,
            controller: descriptionTextController,
            onChanged: (value) {
              description = value;
            },
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              labelText: "Description",
            ),
          ),
          // TextField(
          //   textAlign: TextAlign.left,
          //   onChanged: (value) {
          //     image = value;
          //   },
          //   keyboardType: TextInputType.text,
          //   decoration: InputDecoration(
          //     labelText: "Image",
          //   ),
          // ),
          TextField(
            textAlign: TextAlign.left,
            controller: categoryTextController,
            onChanged: (value) {
              category = value;
            },
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              labelText: "Category",
            ),
          ),
          RaisedButton(
            elevation: 5.0,
            color: Colors.teal.shade300,
            onPressed: () async {
              setState(() {
                showSpinner = true;
              });
              _firestore.collection('products').add({
                'productname': productName,
                'description': description,
                'category': category,
              });
              Navigator.pushNamed(context, HomePage.id);
            },
            child: Text('Upload Gift'),
          ),
          Column(
            children: [
              RaisedButton(
                elevation: 5.0,
                color: Colors.teal.shade300,
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Cancel'),
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: BottomNavBarWidget(),
    );
  }
}

