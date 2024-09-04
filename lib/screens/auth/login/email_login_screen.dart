import 'package:flutter/material.dart';
import 'package:littoon/screens/auth/login/sns_login_screen.dart';

class EmailLoginScreen extends StatelessWidget {
  const EmailLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Email Login"),
        automaticallyImplyLeading: false,
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Email Login"),
          ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('back'))
        ],
      )),
    );
  }
}
