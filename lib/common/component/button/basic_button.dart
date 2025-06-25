import 'package:flutter/material.dart';
import 'package:gu_pos/common/const/colors.dart';

import '../text/body_text.dart';

class BasicButton extends StatelessWidget {
  final String title;
  final Color backgroundColor;
  final Color textColor;

  final Icon? icon;

  const BasicButton(this.title, {super.key,
      required this.backgroundColor,
      required this.textColor,
      this.icon
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if(icon != null)
                _Icon(icon!),
              BodyText(title,
                textSize: BodyTextSize.REGULAR,
                color: textColor,
                fontWeight: FontWeight.w400,
              ),
            ],
          ),
        )
    );
  }

  Widget _Icon(Icon icon) {
    return Row(
      children: [
        icon,
        SizedBox(width: 3.0,)
      ],
    );
  }
}
