import 'package:flutter/material.dart';
import 'package:littoon/screens/auth/login/sns_login_screen.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Home"),
          automaticallyImplyLeading: false,
        ),
        body: Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text("Home"),
          ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('back')),
          ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SocialLogInScreen()));
              },
              child: Text("LogOut")),
        ])));
  }
}
