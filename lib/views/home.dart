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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text('Home Screen'),
      ),
      body: Center(
          child: Column(
            children: [
              RaisedButton(
                onPressed: () {
                  context.read<AuthenticationService>().SignOut();
                  Navigator.of(context).pushNamed(AppRoutes.authLogin);
                },
                child: Text('Sign Out'),
              )
            ],
          )
      ),
    );
  }
}