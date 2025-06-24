import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gu_pos/common/const/colors.dart';

class TitleText extends StatelessWidget {
  final String title;
  Color? color;
  FontWeight? fontWeight;

  TitleText({
    required this.title,
    this.color,
    this.fontWeight,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Text(title,
      style: TextStyle(
        fontSize: Platform.isIOS ? 19 : 18,
        color: color ?? BODY_TEXT_COLOR_02,
        fontWeight: fontWeight ?? FontWeight.w500,
      ),
    );
  }
}