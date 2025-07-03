import 'package:flutter/material.dart';
import 'package:gu_pos/common/component/text/body_text.dart';

import '../../const/colors.dart';

class NumberStepper extends StatefulWidget {
  const NumberStepper({super.key});

  @override
  State<NumberStepper> createState() => _NumberStepperState();
}

class _NumberStepperState extends State<NumberStepper> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _decrementCounter() {
    setState(() {
      _counter--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: PRIMARY_COLOR_04,
          borderRadius: BorderRadius.circular(7)
      ),
      child: Row(
        children: [
          InkWell(
            onTap: () {
              _decrementCounter();
            },
            child: Container(
              width: 46, // 원하는 터치 영역 너비
              height: 40, // 원하는 터치 영역 높이
              alignment: Alignment.center,
              child: const Icon(Icons.remove, color: COLOR_505967,),
            ),
          ),
          Text('$_counter',
            style: TextStyle(
              color: COLOR_505967,
              fontSize: 18
            ),
          ),
          InkWell(
            onTap: () {
              _incrementCounter();
            },
            child: Container(
              width: 46, // 원하는 터치 영역 너비
              height: 40, // 원하는 터치 영역 높이
              alignment: Alignment.center,
              child: const Icon(Icons.add, color: COLOR_505967,),
            ),
          ),
        ],
      )
    );
  }
}
