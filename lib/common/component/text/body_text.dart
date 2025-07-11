import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../const/colors.dart';

class BodyText extends StatelessWidget {
  final String title;
  final BodyTextSize textSize;
  Color? color;
  FontWeight? fontWeight;
  bool? numberFormat;

  BodyText(this.title,{
    required this.textSize,
    this.color,
    this.fontWeight,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Text(title,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontSize: Platform.isIOS ? textSize.value + 1 : textSize.value,
        color: color ?? TEXT_COLOR_05,
        fontWeight: fontWeight ?? FontWeight.w400,
      ),
    );
  }
}

enum BodyTextSize {
  SMALL(12),
  SMALL_HALF(13),
  REGULAR(14),
  REGULAR_HALF(15),
  MEDIUM(16),
  MEDIUM_HALF(17),
  LARGE(18),
  LARGE_HALF(19),
  HUGE(20),
  HUGE_HALF(21)
  ;

  const BodyTextSize(this.value);
  final double value;
}


