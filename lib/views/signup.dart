import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:passdown/common_widget/bottom_navbar_widget.dart';
import 'package:passdown/views/home.dart';
import 'package:passdown/views/signin.dart';

class SignUpPage extends StatefulWidget {
  static const String id = 'signup';
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {

  String emailController;
  String passwordController;
  String rePasswordController;
  String phoneController;

  final _auth = FirebaseAuth.instance;
  bool showSpinner = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text('Sign Up Screen'),
      ),
      body: Column(
        children: [
          TextField(
            textAlign: TextAlign.left,
            onChanged: (value) {
              emailController = value;
            },
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              labelText: "Email",
            ),
          ),
          TextField(
            onChanged: (value) {
              phoneController = value;
            },
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
              labelText: "Phone",
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
          TextField(
            onChanged: (value) {
              rePasswordController = value;
            },
            obscureText: true,
            decoration: InputDecoration(
              labelText: "Confirm Password",
            ),
          ),
          RaisedButton(
            elevation: 5.0,
            color: Colors.teal.shade300,
            onPressed: () async {
              setState(() {
                showSpinner = true;
              });
              try {
                final newUser = await _auth.createUserWithEmailAndPassword(
                    email: emailController, password: emailController);
                if (newUser != null) {
                  Navigator.pushNamed(context, HomePage.id);
                }
                setState(() {
                  showSpinner = false;
                });
              } catch (e) {
                print(e);
              }
            },
            child: Text('Sign Up'),
          ),
          Column(
            children: [
                  RaisedButton(
                    elevation: 5.0,
                    color: Colors.teal.shade300,
                    onPressed: () {
                      Navigator.pushNamed(context, SignInPage.id);
                    },
                    child: Text('Already Registred? Sign In'),
                  ),
                ],
          ),
        ],
      ),
      //bottomNavigationBar: BottomNavBarWidget(),
    );
  }
}
