import 'package:flutter/material.dart';

class EmailSignupScreen extends StatelessWidget {
  const EmailSignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Email SignUp"),
        automaticallyImplyLeading: false,
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Email Sign Up"),
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
