import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
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
                _logout(context);
              },
              child: Text("LogOut")),
        ])));
  }

  void _logout(BuildContext context) async {
    // String? email = FirebaseAuth.instance.currentUser?.email;
    // // Firebase 로그아웃
    // await FirebaseAuth.instance.signOut();
    // // Google 로그아웃
    // await GoogleSignIn().signOut();
    // Kakao 로그아웃
    try {
      await UserApi.instance.logout();
    } catch (error) {
      print('Kakao logout failed: $error');
    }
    // 로그 기록

    print('User logged out');

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => SocialLogInScreen()),
    );
  }
}
