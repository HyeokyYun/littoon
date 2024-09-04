import 'package:flutter/material.dart';

import '../../home/home.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("프로필 설정"),
        automaticallyImplyLeading: false,
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("User Profile"),
          ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Home()));
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
