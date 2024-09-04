import 'package:flutter/material.dart';
import 'package:littoon/screens/auth/login/email_login_screen.dart';
import 'package:littoon/screens/auth/signup/email_signup_screen.dart';
import 'package:littoon/screens/auth/userinfo/user_interest.dart';

class SocialLogInScreen extends StatelessWidget {
  const SocialLogInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Social Login"),
          automaticallyImplyLeading: false,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Social Login"),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => UserInterestScreen()));
                  },
                  child: Text("소셜 로그인")),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EmailLoginScreen()));
                  },
                  child: Text("이메일 로그인")),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EmailSignupScreen()));
                  },
                  child: Text("이메일 회원가입"))
            ],
          ),
        ));
  }
}
