import 'package:flutter/material.dart';
import 'package:gu_pos/common/const/colors.dart';

import '../text/body_text.dart';

class BasicButtonV2 extends StatelessWidget {
  final BodyText text;
  final Color backgroundColor;
  final BorderRadiusGeometry? radius;
  final Icon? icon;
  final EdgeInsetsGeometry? padding;

  const BasicButtonV2({
    required this.text,
    required this.backgroundColor,
    this.radius,
    this.icon,
    this.padding,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: radius ?? BorderRadius.circular(5),
        ),
        child: Padding(
          padding: padding ?? const EdgeInsets.symmetric(horizontal: 18.0, vertical: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if(icon != null)
                _Icon(icon!),
                text
            ],
          ),
        )
    );
  }

  Widget _Icon(Icon icon) {
    return Row(
      children: [
        icon
      ],
    );
  }
}
