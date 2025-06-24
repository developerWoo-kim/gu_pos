import 'dart:io';

import 'package:flutter/material.dart';

import '../../const/colors.dart';

class BodyText extends StatelessWidget {
  final String title;
  final BodyTextSize textSize;
  Color? color;
  FontWeight? fontWeight;

  BodyText({
    required this.title,
    required this.textSize,
    this.color,
    this.fontWeight,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Text(title,
      style: TextStyle(
        fontSize: Platform.isIOS ? textSize.value + 1 : textSize.value,
        color: color ?? BODY_TEXT_COLOR_02,
        fontWeight: fontWeight ?? FontWeight.w400,
      ),
    );
  }
}

enum BodyTextSize {
  REGULAR(14),
  MEDIUM(16),
  LARGE(18);

  const BodyTextSize(this.value);
  final double value;
}


