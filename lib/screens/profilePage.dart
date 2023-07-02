import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

//user profile page with logout button
class ProfilePage extends StatelessWidget {
  final user = FirebaseAuth.instance.currentUser!;
  void _signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            user.photoURL!= null
                        ? CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(user.photoURL!),
            ): CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage('https://upload.wikimedia.org/wikipedia/commons/a/ac/Default_pfp.jpg'),
            ),
            
            SizedBox(height:20),
            Text(
              user.email!,
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
              SizedBox(height:30),
            ElevatedButton(
              onPressed: () {
                _signUserOut();
              },
              child: Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}
