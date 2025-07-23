import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../const/colors.dart';

class CustomRadioButton extends StatelessWidget {
  final bool isSelected;
  final VoidCallback? onTap;

  const CustomRadioButton({
    Key? key,
    required this.isSelected,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        // width: 20,
        height: 28,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: isSelected ? PRIMARY_COLOR_01 : TEXT_COLOR_04,
            width: 2,
          ),
          color: isSelected ? PRIMARY_COLOR_01 : Colors.transparent,
        ),
        child: isSelected
            ? Center(
          child: Icon(
            Icons.check_rounded,
            size: 22,
            color: Colors.white,
          ),
        )
            : null,
      ),
    );
  }
}