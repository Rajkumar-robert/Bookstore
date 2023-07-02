import 'package:bookstore/screens/loginPage.dart';
import 'package:bookstore/screens/main_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

//class to check if the user is logged in or not
class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return mainPage();
        }
        else {
          return LoginPage();
        }
      },
    )); 
  }
}
