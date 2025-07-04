import 'package:flutter/material.dart';
import 'package:gu_pos/common/component/text/body_text.dart';

import '../../const/colors.dart';

class NumberStepper extends StatelessWidget {
  final int counter;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  const NumberStepper({
    super.key,
    required this.counter,
    required this.onIncrement,
    required this.onDecrement,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: PRIMARY_COLOR_04,
        borderRadius: BorderRadius.circular(7),
      ),
      child: Row(
        children: [
          InkWell(
            onTap: onDecrement,
            child: Container(
              width: 46,
              height: 40,
              alignment: Alignment.center,
              child: const Icon(Icons.remove, color: COLOR_505967),
            ),
          ),
          Text('$counter',
            style: const TextStyle(
              color: COLOR_505967,
              fontSize: 18,
            ),
          ),
          InkWell(
            onTap: onIncrement,
            child: Container(
              width: 46,
              height: 40,
              alignment: Alignment.center,
              child: const Icon(Icons.add, color: COLOR_505967),
            ),
          ),
        ],
      ),
    );
  }
}
