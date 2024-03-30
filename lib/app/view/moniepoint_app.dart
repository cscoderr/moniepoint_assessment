import 'package:flutter/material.dart';
import 'package:moniepoint_test/core/core.dart';
import 'package:moniepoint_test/presentation/bottom_bar/view/bottom_bar_page.dart';

class MoniepointApp extends StatelessWidget {
  const MoniepointApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: const AppTheme().lightTheme,
      darkTheme: const AppTheme().darkTheme,
      home: const BottomBarPage(),
    );
  }
}
