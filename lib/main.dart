import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:passdown/views/home.dart';
import 'package:passdown/views/signin.dart';
import 'package:passdown/views/signup.dart';
import 'package:passdown/views/upload_products.dart';
import 'package:passdown/views/welcome_screen.dart';
import 'package:passdown/views/wish_list.dart';

/// Requires that a Firestore emulator is running locally.
/// See https://firebase.flutter.dev/docs/firestore/usage#emulator-usage
bool USE_FIRESTORE_EMULATOR = false;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  if (USE_FIRESTORE_EMULATOR) {
    FirebaseFirestore.instance.settings = Settings(
        host: 'localhost:8080', sslEnabled: false, persistenceEnabled: false);
  }
  runApp(MyApp());
}

//Class MyApp
class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Object>(
      stream: null,
      builder: (context, snapshot) {
        return MaterialApp(
            title: 'Passdown App',
            theme: ThemeData(
              primarySwatch: Colors.teal,
              visualDensity: VisualDensity.adaptivePlatformDensity,
            ),
            initialRoute: WelcomeScreen.id,
            routes: {
              WelcomeScreen.id: (context) => WelcomeScreen(),
              SignInPage.id: (context) => SignInPage(),
              SignUpPage.id: (context) => SignUpPage(),
              HomePage.id: (context) => HomePage(),
              WishListPage.id: (context) => WishListPage(),
              UploadProductPage.id: (context) => UploadProductPage(),
            },
        );
      }
    );
  }
}

