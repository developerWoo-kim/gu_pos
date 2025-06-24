import 'package:flutter/material.dart';

import '../const/colors.dart';

class DefaultLayout extends StatelessWidget {
  final AppBar? appBar;
  final Widget body;
  final Color? backgroundColor;
  final Widget? bottomNavigationBar;

  const DefaultLayout({super.key,
      this.appBar,
      required this.body,
      this.backgroundColor,
      this.bottomNavigationBar
      });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: backgroundColor ?? PRIMARY_COLOR_04,
      appBar: appBar,
      body: body,
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}
