import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:passdown/authentication_service.dart';
import 'package:passdown/theme/routes.dart';
import 'package:passdown/common_widget/app_bar_widget.dart';
import 'package:passdown/common_widget/drawer_widget.dart';
import 'package:passdown/common_widget/bottom_navbar_widget.dart';
import 'package:passdown/views/home.dart';
import 'package:passdown/views/signin.dart';
import 'package:passdown/views/signup.dart';


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
          context
              .read<AuthenticationService>()
              .authStateChanges,
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
class AuthenticationWrapper extends StatefulWidget {
  AuthenticationWrapper({
    Key key,
  }) : super(key: key);

  @override
  _AuthenticationWrapperState createState() => _AuthenticationWrapperState();
}

class _AuthenticationWrapperState extends State<AuthenticationWrapper> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
            appBar: appBarWidget(context),
            drawer: DrawerWidget(),
            body: IndexedStack(
              //index: currentIndex,
              //children: viewContainer,
            // final firebaseuser = context.watch<User>();
            //
            // if (firebaseuser != null) {
            // return SignInPage();
            // }
            // return HomePage();
    ),
    bottomNavigationBar: BottomNavBarWidget(),
    ),
    );
  }
}
