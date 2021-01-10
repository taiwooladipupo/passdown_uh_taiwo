import 'package:flutter/material.dart';
import 'package:passdown/common_widget/bottom_navbar_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:passdown/views/home.dart';
import 'package:passdown/views/signup.dart';

class SignInPage extends StatefulWidget {
  static const String id = 'signin';

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {

  bool showSpinner = false;
  final _auth =FirebaseAuth.instance;
  String emailController;
  String passwordController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text('Sign In Screen'),
      ),
      body: Column(
        children: [
          TextField(
            textAlign: TextAlign.center,
            onChanged: (value) {
              emailController = value;
            },
            decoration: InputDecoration(
              labelText: "Email",
            ),
          ),
          TextField(
            onChanged: (value) {
              passwordController = value;
            },
            obscureText: true,
            decoration: InputDecoration(
              labelText: "Password",
            ),
          ),
          RaisedButton(
            onPressed: () async {
              setState(() {
                showSpinner = true;
              });
              try {
                final user = await _auth.signInWithEmailAndPassword(
                    email: emailController, password: passwordController);
                if (user != null) {
                  Navigator.pushNamed(context, HomePage.id);
                }
                setState(() {
                  showSpinner = false;
                });
              } catch (e) {
                print(e);
              }
            },
            child: Text('Sign In'),
          ),
          Column(
            children: [
              RaisedButton(
                onPressed: () {
                  Navigator.pushNamed(context, SignUpPage.id);
                },
                child: Text('Don\'t have an account? Register'),
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: BottomNavBarWidget(),
    );
  }
}
