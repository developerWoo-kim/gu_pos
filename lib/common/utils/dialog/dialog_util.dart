import 'package:flutter/material.dart';

import '../../const/colors.dart';

class DialogUtil {

  static void basicLayout(BuildContext context, {
    required Widget content
  }) {
    showDialog<String>(
        context: context,
        // barrierColor: Colors.cyan.withOpacity(0.4),
        barrierDismissible: true,
        builder: (context) {
          return Dialog(
            // /// 배경 컬러
            // backgroundColor: Colors.grey.shade100,
            // /// 그림자 컬러
            // shadowColor: Colors.blue,
            /// 다이얼로그의 모양 설정
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            /// z축 높이, elevation의 값이 높을 수록 그림자가 아래 위치하게 됩니다.
            // elevation: 10,
            // /// 다이얼로그의 위치 설정, 기본값은 center
            // alignment: Alignment.bottomCenter,
            child: Container(
                width: 750,
                height: 750,
                decoration: BoxDecoration(
                  color: PRIMARY_COLOR_04,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: content,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 25, bottom: 30, right: 26),
                      child: SizedBox(
                        width: 50,
                        child: Column(
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: const Icon(Icons.close_rounded, color: TEXT_COLOR_03, size: 42,)
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                )
            ),
          );
        }
    );
  }
}