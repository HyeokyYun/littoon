import 'package:flutter/material.dart';
import 'package:littoon/screens/auth/userinfo/user_profile.dart';

class UserInterestScreen extends StatelessWidget {
  const UserInterestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("장르 선택"),
        automaticallyImplyLeading: false,
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("User Interest Selection"),
          ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => UserProfileScreen()));
              },
              child: Text("완료")),
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
