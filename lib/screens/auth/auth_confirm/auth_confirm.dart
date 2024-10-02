import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:littoon/screens/home/home.dart';
import 'package:url_launcher/url_launcher.dart';

class UserConfirmScreen extends StatefulWidget {
  const UserConfirmScreen({super.key});

  @override
  State<UserConfirmScreen> createState() => _UserConfirmScreenState();
}

class _UserConfirmScreenState extends State<UserConfirmScreen> {
  Future<void> _launchURL() async {
    final Uri url = Uri.parse('https://www.naver.com');
    if (!await launchUrl(url)) {
      throw 'Could not launch $url';
    }
  }

  List<bool> _isChecked = List.generate(5, (_) => false);

  // '다음' 버튼 활성 상태 체크 (필수 동의 항목들이 모두 체크되었는지 확인)
  bool get _buttonActive => _isChecked[1] && _isChecked[2] && _isChecked[3];

  void _updateCheckState(int index) {
    setState(() {
      // '전체 동의' 항목 체크시 나머지 항목 모두 동의 처리
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
        child: SingleChildScrollView(
          child: Column(
            children: [
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
              ..._renderCheckList(),
              SizedBox(
                height: 79.h,
              ),
              SizedBox(
                width: 361.w,
                height: 45.h,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: _buttonActive
                          ? const Color(0xff1F2ADD) // 활성화 상태
                          : Color(0xff979797), // 비활성화 상태
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero)),
                  // 버튼 활성 상태에 따라 onPressed를 설정
                  onPressed: _buttonActive
                      ? () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => Home()));
                        }
                      : null, // 비활성화일 때는 null
                  child: Text(
                    '다음',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _renderCheckList() {
    List<String> labels = [
      '전체 동의',
      '서비스 이용약관 동의 (필수)',
      '개인정보 수집 및 이용 동의 (필수)',
      '만 14세 이상 확인 (필수)',
      '마케팅 수신 동의 (선택)'
    ];
    List<Widget> list = [
      renderContainer(_isChecked[0], labels[0], () => _updateCheckState(0)),
      Divider(
        thickness: 1.0,
        color: const Color(0xff979797),
        indent: 17.w,
        endIndent: 17.w,
      ),
    ];

    list.addAll(List.generate(4, (index) {
      // 두 번째와 세 번째 항목에는 '내용보기' 버튼 추가
      bool hasViewContentButton = index == 0 || index == 1;
      return Column(
        children: [
          renderContainer(_isChecked[index + 1], labels[index + 1],
              () => _updateCheckState(index + 1),
              showViewContentButton: hasViewContentButton),
        ],
      );
    }));

    return list;
  }

  Widget renderContainer(bool checked, String text, VoidCallback onTap,
      {bool showViewContentButton = false}) {
    // '전체 동의'인지 여부 확인
    bool isAllAgree = text == '전체 동의';

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding:
            EdgeInsets.only(left: 17.w, top: 8.h, bottom: 8.h, right: 17.w),
        color: Colors.white,
        child: Row(
          children: [
            Icon(Icons.check_box_rounded,
                color:
                    checked ? const Color(0xff1F2ADD) : const Color(0xffD9D9D9),
                size: 22.h),
            SizedBox(width: 12.w),
            // '전체 동의'에만 다른 스타일 적용
            Expanded(
              child: isAllAgree
                  ? Text(
                      text,
                      style: TextStyle(
                        color: const Color(0xff070707),
                        fontSize: 20.sp, // 큰 폰트 사이즈
                        fontWeight: FontWeight.bold, // 볼드체
                      ),
                    )
                  : _buildRichText(text),
            ),
            if (showViewContentButton)
              TextButton(
                onPressed: _launchURL,
                style: TextButton.styleFrom(overlayColor: Colors.transparent),
                child: Text(
                  '내용보기',
                  style: TextStyle(
                      fontSize: 14.sp,
                      color: const Color(0xff979797),
                      decoration: TextDecoration.underline,
                      decorationColor: const Color(0xff979797)),
                ),
              ),
          ],
        ),
      ),
    );
  }

  // "(필수)" 또는 "(선택)"이 포함된 항목을 RichText로 빌드하는 함수
  Widget _buildRichText(String text) {
    String requiredTag = '(필수)';
    String optionalTag = '(선택)';

    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: text.contains(requiredTag)
                ? text.replaceAll(requiredTag, '')
                : text.replaceAll(optionalTag, ''),
            style: TextStyle(
              color: const Color(0xff070707),
              fontSize: 16.sp,
            ),
          ),
          if (text.contains(requiredTag))
            TextSpan(
              text: requiredTag,
              style: TextStyle(
                color: const Color(0xff1F2ADD), // '(필수)'의 색상 변경
                fontSize: 16.sp,
              ),
            ),
          if (text.contains(optionalTag))
            TextSpan(
              text: optionalTag,
              style: TextStyle(
                color: const Color(0xff979797), // '(선택)'의 색상
                fontSize: 16.sp,
              ),
            ),
        ],
      ),
    );
  }
}
