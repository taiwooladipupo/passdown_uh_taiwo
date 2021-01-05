import 'package:flutter/material.dart';
import 'package:passdown/authentication_service.dart';
import 'package:passdown/theme/routes.dart';
import 'package:provider/provider.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {

  final TextEditingController emailController  = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController rePasswordController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple.shade900,
        title: Text('Sign Up Screen'),
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
            controller: phoneController,
            decoration: InputDecoration(
              labelText: "Phone",
            ),
          ),
          TextField(
            controller: passwordController,
            decoration: InputDecoration(
              labelText: "Password",
            ),
          ),
          TextField(
            controller: rePasswordController,
            decoration: InputDecoration(
              labelText: "Confirm Password",
            ),
          ),
          RaisedButton(
            onPressed: () {
              context.read<AuthenticationService>().SignUp(
                  email: emailController.text.trim(),
                  password: passwordController.text.trim()
              );
            },
            child: Text('Sign Up'),
            //TODO: Activate OTP
          ),
          Column(
            children: [
                  RaisedButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed(AppRoutes.authLogin);
                    },
                    child: Text('Already Registred? Sign In'),
                  ),
                ],
          ),
        ],
      ),
    );
  }
}
