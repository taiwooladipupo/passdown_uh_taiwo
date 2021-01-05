import 'package:flutter/material.dart';
import 'package:passdown/authentication_service.dart';
import 'package:passdown/theme/routes.dart';
import 'package:passdown/views/home.dart';
import 'package:passdown/views/signup.dart';
import 'package:provider/provider.dart';
import 'package:passdown/theme/routes.dart';


class SignInPage extends StatefulWidget {

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final TextEditingController emailController  = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple.shade900,
        title: Text('Sign In Screen'),
      ),
      body: Column(
        children: [
          TextField(
            controller: emailController,
            decoration: InputDecoration(
              labelText: "Email",
            ),
          ),
          TextField(
            controller: passwordController,
            decoration: InputDecoration(
              labelText: "Password",
            ),
          ),
          RaisedButton(
            onPressed: () {
              context.read<AuthenticationService>().SignIn(
                  email: emailController.text.trim(),
                  password: passwordController.text.trim()
              );
              Navigator.of(context).pushNamed(AppRoutes.authHome);
            },
            child: Text('Sign In'),
          ),
          Column(
            children: [
              RaisedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(AppRoutes.authRegister);
                },
                child: Text('Don\'t have an account? Register'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
