import 'package:flutter/material.dart';
import 'package:passdown/authentication_service.dart';
import 'package:passdown/theme/routes.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final title = 'Grid List';

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple.shade900,
        title: Text('Welcome Home'),
      ),
      body: GridView.count(
        // Create a grid with 2 columns. If you change the scrollDirection to
        // horizontal, this produces 2 rows.
          crossAxisCount: 2,
          // Generate 100 widgets that display their index in the List.
          children: List.generate(10, (index) {
            return Center(
              child: Text(
                'Item $index',
                style: Theme.of(context).textTheme.headline5,
              ),
             child: RaisedButton(
                    onPressed: () {
              context.read<AuthenticationService>().SignOut();
              Navigator.of(context).pushNamed(AppRoutes.authLogin);
              },
                child: Text('Sign Out'),
              ),
            );
          }),
      ),
    );
  }
}
