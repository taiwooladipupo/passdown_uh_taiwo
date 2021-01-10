import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

/// A single movie row.
class Product extends StatelessWidget {
  /// Contains all snapshot data for a given movie.
  final DocumentSnapshot snapshot;

  /// Initialize a [Move] instance with a given [DocumentSnapshot].
  Product(this.snapshot);

  /// Returns the [DocumentSnapshot] data as a a [Map].
  Map<String, dynamic> get movie {
    return snapshot.data();
  }

  /// Returns the movie poster.
  Widget get poster {
    return Container(
      width: 100,
      child: Center(child: Image.network(movie['poster'])),
    );
  }

  /// Returns movie details.
  Widget get details {
    return Padding(
        padding: EdgeInsets.only(left: 8, right: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            title,
            metadata,
            genres,
            Likes(
              reference: snapshot.reference,
              currentLikes: movie['likes'],
            )
          ],
        ));
  }

  /// Return the movie title.
  Widget get title {
    return Text("${movie['title']} (${movie['year']})",
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold));
  }

  /// Returns metadata about the movie.
  Widget get metadata {
    return Padding(
        padding: EdgeInsets.only(top: 8),
        child: Row(children: [
          Padding(
              child: Text('Rated: ${movie['rated']}'),
              padding: EdgeInsets.only(right: 8)),
          Text('Runtime: ${movie['runtime']}'),
        ]));
  }

  /// Returns a list of genre movie tags.
  List<Widget> genreItems() {
    List<Widget> items = <Widget>[];
    movie['genre'].forEach((genre) {
      items.add(Padding(
        child: Chip(
            label: Text(genre, style: TextStyle(color: Colors.white)),
            backgroundColor: Colors.lightBlue),
        padding: EdgeInsets.only(right: 2),
      ));
    });
    return items;
  }

  /// Returns all genres.
  Widget get genres {
    return Padding(
        padding: EdgeInsets.only(top: 8), child: Wrap(children: genreItems()));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(bottom: 4, top: 4),
        child: Container(
          child: Row(
            children: [poster, Flexible(child: details)],
          ),
        ));
  }
}

/// Displays and manages the movie "like" count.
class Likes extends StatefulWidget {
  /// The [DocumentReference] relating to the counter.
  final DocumentReference reference;

  /// The number of current likes (before manipulation).
  final num currentLikes;

  /// Constructs a new [Likes] instance with a given [DocumentReference] and
  /// current like count.
  Likes({Key key, this.reference, this.currentLikes}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _Likes();
  }
}

class _Likes extends State<Likes> {
  int _likes;

  _onLike(int current) async {
    // Increment the "like" count straight away to show feedback to the user.
    setState(() {
      _likes = current + 1;
    });

    try {
      // Return and set the updated "likes" count from the transaction
      int newLikes = await FirebaseFirestore.instance
          .runTransaction<int>((transaction) async {
        DocumentSnapshot txSnapshot = await transaction.get(widget.reference);

        if (!txSnapshot.exists) {
          throw Exception("Document does not exist!");
        }

        int updatedLikes = (txSnapshot.data()['likes'] ?? 0) + 1;
        transaction.update(widget.reference, {'likes': updatedLikes});
        return updatedLikes;
      });

      // Update with the real count once the transaction has completed.
      setState(() {
        _likes = newLikes;
      });
    } catch (e, s) {
      print(s);
      print("Failed to update likes for document! $e");

      // If the transaction fails, revert back to the old count
      setState(() {
        _likes = current;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    int currentLikes = _likes ?? widget.currentLikes ?? 0;

    return Row(children: [
      IconButton(
          icon: Icon(Icons.favorite),
          iconSize: 20,
          onPressed: () {
            _onLike(currentLikes);
          }),
      Text("$currentLikes likes"),
    ]);
  }
}