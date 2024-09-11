import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:littoon/screens/home/home.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // kakao login start
  KakaoSdk.init(
      nativeAppKey: '63b0a3e1542409b7fc8259c307069d92',
      javaScriptAppKey: '246df042a49527580daa2b0b82e384b0');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: Size(393, 759),
        builder: (_, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
                scaffoldBackgroundColor: Colors.white,
                appBarTheme: AppBarTheme(backgroundColor: Colors.white),
                textTheme: TextTheme()),
            home: Home(),
          );
        });
  }
}
