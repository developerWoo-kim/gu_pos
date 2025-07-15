import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gu_pos/common/layout/default_layout.dart';
import 'package:gu_pos/style_guide_screen.dart';

import 'common/const/colors.dart';

void main() {
  runApp(
      const ProviderScope(
        // observers: [
        //   LoggerProvider()
        // ],
        child: MyApp(),
      )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'SpoqaHanSansNeo',
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        extendBody: true,
        backgroundColor: PRIMARY_COLOR_04,
        appBar: null,
        body: StyleGuideScreen(),
      )
    );
  }
}

