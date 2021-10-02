import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'provider/google_sign_in_provider.dart';
import 'screens/auth_screen/auth_page.dart';
import 'screens/home_screen/home_screen.dart';

class InitialPage extends StatefulWidget {
  const InitialPage({Key? key}) : super(key: key);

  @override
  _InitialPageState createState() => _InitialPageState();
}

class _InitialPageState extends State<InitialPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          final provider = Provider.of<GoogleSignInProvider>(context);
          if (provider.isSigningIn) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasData) {
            return const HomeScreen();
          } else {
            return const AuthPage();
          }
        },
      ),
    );
  }
}
