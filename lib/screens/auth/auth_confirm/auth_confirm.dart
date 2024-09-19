import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserConfirmScreen extends StatefulWidget {
  const UserConfirmScreen({super.key});

  @override
  State<UserConfirmScreen> createState() => _UserConfirmScreenState();
}

class _UserConfirmScreenState extends State<UserConfirmScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 156.h,
            ),
            Image.asset(
              "assets/images/logo=basic_logo.png",
              height: 32.h,
              width: 146.w,
            ),
            SizedBox(
              height: 20.h,
            ),
            Text(
              "더 좋은 서비스를 제공하 위해\n노력하는 릿툰이 될게요!",
              style: TextStyle(fontSize: 16.sp, height: 1.3),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 94.h,
            ),
            TermsOfAgreement()
          ],
        ),
      ),
    );
  }
}

class TermsOfAgreement extends StatefulWidget {
  const TermsOfAgreement({super.key});

  @override
  State<TermsOfAgreement> createState() => _TermsOfAgreementState();
}

class _TermsOfAgreementState extends State<TermsOfAgreement> {
  List<bool> _isChecked = List.generate(5, (_) => false);

  bool get _buttonActive => _isChecked[1] && _isChecked[2] && _isChecked[3];

  void _updateCheckState(int index) {
    setState(() {
      // 모두 동의 체크박스일 경우
      if (index == 0) {
        bool isAllChecked = !_isChecked.every((element) => element);
        _isChecked = List.generate(5, (index) => isAllChecked);
      } else {
        _isChecked[index] = !_isChecked[index];
        _isChecked[0] = _isChecked.getRange(1, 5).every((element) => element);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ..._renderCheckList(),
        Spacer(),
        Row(
          children: [
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: _buttonActive ? Colors.blue : Colors.grey,
                ),
                onPressed: () {},
                child: const Text(
                  '가입하기',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  List<Widget> _renderCheckList() {
    List<String> labels = [
      '전채 동의',
      '서비스 이용약관 동의 (필수)',
      '개인정보 수집 및 이용 동의 (필수)',
      '만 14세 이상 확인 (필수)',
      '마케팅 수신 동의 (선택)'
    ];

    List<Widget> list = [
      renderContainer(_isChecked[0], labels[0], () => _updateCheckState(0)),
      const Divider(thickness: 1.0),
    ];

    list.addAll(List.generate(
        4,
        (index) => renderContainer(_isChecked[index + 1], labels[index + 1],
            () => _updateCheckState(index + 1))));

    return list;
  }

  Widget renderContainer(bool checked, String text, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
        color: Colors.white,
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                    color: checked ? Colors.blue : Colors.grey, width: 2.0),
                color: checked ? Colors.blue : Colors.white,
              ),
              child: Icon(Icons.check,
                  color: checked ? Colors.white : Colors.grey, size: 18),
            ),
            const SizedBox(width: 15),
            Text(text,
                style: const TextStyle(color: Colors.grey, fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
