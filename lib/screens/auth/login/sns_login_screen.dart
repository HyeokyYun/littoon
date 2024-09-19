import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:littoon/screens/auth/auth_confirm/auth_confirm.dart';
import 'package:littoon/screens/auth/login/email_login_screen.dart';
import 'package:littoon/screens/auth/signup/email_signup_screen.dart';
import 'package:littoon/screens/auth/userinfo/user_interest.dart';
import 'package:littoon/screens/home/home.dart';

class SocialLogInScreen extends StatelessWidget {
  const SocialLogInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(45.h),
        child: AppBar(
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Home()));
            },
            icon: Image.asset(
              'assets/icons/lit icon=X.png',
              width: 22.w,
              height: 22.h,
            ),
          ),
          automaticallyImplyLeading: false,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                SizedBox(
                  width: 263.w,
                ),
                Image.asset(
                  'assets/images/Fire.png',
                  width: 51.w,
                  height: 65.h,
                ),
              ],
            ),
            SizedBox(
              height: 16.44.h,
            ),
            Row(
              children: [
                Image.asset(
                  'assets/images/heart.png',
                  width: 81.w,
                  height: 46.h,
                ),
              ],
            ),
            SizedBox(
              height: 14.h,
            ),
            Center(
              child: Image.asset(
                'assets/images/logo=basic_logo.png',
                width: 146.w,
                height: 32.h,
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Text(
              "로그인하면 내가 본 작품을 저장하고, \n내 작품을 올릴 수 있어요",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 16.sp, color: Color(0xff070707), height: 1.3),
            ),
            SizedBox(
              height: 7.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Image.asset(
                  'assets/images/hand_shaking.png',
                  width: 57.w,
                  height: 57.h,
                ),
              ],
            ),
            SizedBox(
              height: 9.h,
            ),
            GestureDetector(
                onTap: () {
                  _loginWithKakao(context);
                },
                // onTap: () {
                //   Navigator.push(
                //       context,
                //       MaterialPageRoute(
                //           builder: (context) => UserInterestScreen()));
                // },
                child: SizedBox(
                  child: Image.asset('assets/images/카카오로그인.png'),
                )),
            SizedBox(
              height: 16.h,
            ),
            GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => UserInterestScreen()));
                },
                child: SizedBox(
                  child: Image.asset('assets/images/구글 로그인.png'),
                )),
            SizedBox(
              height: 21.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  child: Text(
                    "이메일 로그인",
                    style: TextStyle(
                        color: Color(0xff070707),
                        fontSize: 14.sp,
                        fontWeight: FontWeight.normal),
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EmailLoginScreen()));
                  },
                  style: TextButton.styleFrom(
                      overlayColor: Colors.grey,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(0)))),
                ),
                Text(
                  "|",
                  style: TextStyle(fontSize: 14.sp),
                ),
                TextButton(
                  child: Text(
                    "이메일 회원가입",
                    style: TextStyle(
                        color: Color(0xff070707),
                        fontSize: 14.sp,
                        fontWeight: FontWeight.normal),
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EmailSignupScreen()));
                  },
                  style: TextButton.styleFrom(
                      overlayColor: Colors.grey,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(0)))),
                ),
              ],
            ),
            SizedBox(
              height: 175.h,
            ),
            TextButton(
              child: Text(
                "비회원 둘러보기",
                style: TextStyle(
                    color: Color(0xff979797),
                    fontSize: 14.sp,
                    fontWeight: FontWeight.normal),
              ),
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Home()));
              },
              style: TextButton.styleFrom(
                  overlayColor: Colors.grey,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(0)))),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _loginWithKakao(BuildContext context) async {
    _showLoadingDialog(context); // 로딩 다이얼로그 표시
    try {
      bool isInstalled = await isKakaoTalkInstalled();
      OAuthToken token;
      if (isInstalled) {
        token = await UserApi.instance.loginWithKakaoTalk();
      } else {
        token = await UserApi.instance.loginWithKakaoAccount();
      }
      print('Login success: ${token.accessToken}');
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => UserConfirmScreen()),
      );
    } catch (e) {
      print('Login failed: $e');
      _hideLoadingDialog(context); // 로딩 다이얼로그 숨기기
    }
  }

  void _showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => PopScope(
        canPop: false,
        child: Dialog(
          backgroundColor: Colors.black.withOpacity(0.75), // 배경색을 진하게 설정
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(
                  valueColor:
                      AlwaysStoppedAnimation<Color>(Colors.white), // 색상 설정
                  strokeWidth: 5.0, // 크기 설정
                ),
                SizedBox(width: 20),
                Text(
                  "Loading...",
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _hideLoadingDialog(BuildContext context) {
    Navigator.pop(context);
  }
}
