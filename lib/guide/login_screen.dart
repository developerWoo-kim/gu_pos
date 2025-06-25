import 'package:flutter/material.dart';
import 'package:gu_pos/common/component/button/basic_button.dart';
import 'package:gu_pos/common/component/form/basic_text_form_field.dart';
import 'package:gu_pos/common/component/text/body_text.dart';
import 'package:gu_pos/common/const/colors.dart';
import 'package:gu_pos/common/layout/default_layout.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 36, vertical: 24),
          child: Column(
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: BasicButton("이전",
                      backgroundColor: BUTTON_BG_COLOR_01,
                      textColor: BUTTON_TEXT_COLOR_01,
                    ),
                  )
                ],
              ),
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Image.asset(
                                'assets/img/logo/logo_01.png',
                                height: 130,
                              ),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: BasicTextFormField(
                                hintText: '휴대폰 번호',
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 14,),
                        Row(
                          children: [
                            Expanded(
                              child: BasicTextFormField(
                                hintText: '비밀번호',
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 14,),
                        BasicButton("로그인",
                          backgroundColor: PRIMARY_COLOR_01,
                          textColor: PRIMARY_COLOR_04,
                        ),
                        SizedBox(height: 20,),
                        BodyText("로그인이 안돼요",
                          textSize: BodyTextSize.SMALL,
                          color: INPUT_TEXT_COLOR_01,
                        )
                      ],
                    )
                  )
                ],
              ),
            ],
          )
        ),
      ),
    );
  }
}
