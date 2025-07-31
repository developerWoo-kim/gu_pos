import 'package:flutter/material.dart';

import '../component/button/hover_button.dart';
import '../component/text/body_text.dart';
import '../const/colors.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 2),
          child: Row(
            children: [
              Expanded(
                child: HoverButton(
                    text: BodyText('주문',
                      textSize: BodyTextSize.REGULAR_HALF,
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 10.0),
                    icon: const Icon(Icons.home_filled, size: 24 , color: TEXT_COLOR_04,),
                    mainAxisAlignment: MainAxisAlignment.start,
                    backgroundColor: PRIMARY_COLOR_04,
                    hoverColor: COLOR_f3f4f6
                ),
              ),
              Expanded(
                child: HoverButton(
                    text: BodyText('결제내역',
                      textSize: BodyTextSize.REGULAR_HALF,

                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 10.0),
                    icon: const Icon(Icons.home_filled, size: 24 , color: TEXT_COLOR_04,),
                    mainAxisAlignment: MainAxisAlignment.start,
                    backgroundColor: PRIMARY_COLOR_04,
                    hoverColor: COLOR_f3f4f6
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 4),
          child: Row(
            children: [
              Expanded(
                child: HoverButton(
                    text: BodyText('매출 리포트',
                      textSize: BodyTextSize.REGULAR_HALF,
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 10.0),
                    icon: const Icon(Icons.home_filled, size: 24 , color: TEXT_COLOR_04,),
                    mainAxisAlignment: MainAxisAlignment.start,
                    backgroundColor: PRIMARY_COLOR_04,
                    hoverColor: COLOR_f3f4f6
                ),
              ),
              Expanded(
                child: HoverButton(
                    text: BodyText('시재 관리',
                      textSize: BodyTextSize.REGULAR_HALF,

                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 10.0),
                    icon: const Icon(Icons.home_filled, size: 24 , color: TEXT_COLOR_04,),
                    mainAxisAlignment: MainAxisAlignment.start,
                    backgroundColor: PRIMARY_COLOR_04,
                    hoverColor: COLOR_f3f4f6
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
