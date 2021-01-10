import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

/// A single product row.
class Product extends StatelessWidget {
  /// Contains all snapshot data for a given product.
  final DocumentSnapshot snapshot;

  /// Initialize a [Move] instance with a given [DocumentSnapshot].
  Product(this.snapshot);

  /// Returns the [DocumentSnapshot] data as a [Map].
  Map<String, dynamic> get products {
    //print(products);
    return snapshot.data();
  }

  /// Returns the product image.
  Widget get imageurl {
    return Container(
      width: 100,
      child: Center(child: Image.network(products['imageurl'])),
    );
  }

  /// Return the product name.
  Widget get productname {
    return Text("${products['productname']})",
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold));
  }

  /// Returns the product description
  Widget get description {
    return Padding(
        padding: EdgeInsets.only(top: 8),
        child: Row(children: [
          Padding(
              child: Text('Description: ${products['description']}'),
              padding: EdgeInsets.only(right: 8)),
          Text('Description: ${products['description']}'),
        ]));
  }

  /// Return the category.
  Widget get category {
    return Text("${products['category']})",
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(bottom: 4, top: 4),
        child: Container(
          child: Row(
            children: [
              productname, Flexible(child: productname),
              description, Flexible(child: description),
              category, Flexible(child: category),
              imageurl, Flexible(child: imageurl),
            ],
          ),
        ));
  }
}