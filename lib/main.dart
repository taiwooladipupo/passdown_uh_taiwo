import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:passdown/authentication_service.dart';
import 'package:passdown/theme/routes.dart';
import 'package:passdown/views/home.dart';
import 'package:passdown/views/signin.dart';
import 'package:passdown/views/signup.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';


//Main Class
Future <void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}


//Class MyApp
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthenticationService>(
          create: (_) => AuthenticationService(FirebaseAuth.instance),
        ),
        StreamProvider(
          create: (context) =>
          context.read<AuthenticationService>().authStateChanges,
        ),
      ],
      child: MaterialApp(
        title: 'Passdown App',
        theme: ThemeData(
          primarySwatch: Colors.purple,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        routes: AppRoutes.define(),
        home: AuthenticationWrapper(),
      ),
    );
  }
}


//Class AuthenticationWrapper
class AuthenticationWrapper extends StatelessWidget {
  AuthenticationWrapper({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final firebaseuser = context.watch<User>();

    if (firebaseuser != null) {
      //return home screen or print
      return SignInPage();
    }
    return HomePage();
  }
}