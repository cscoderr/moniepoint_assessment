import 'dart:io';

import 'package:flutter/material.dart';
import 'package:moniepoint_test/presentation/bottom_bar/view/bottom_bar_page.dart';
import 'package:moniepoint_test/presentation/home/home.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
    required this.appBarAnimationController,
    required this.headerAnimationController,
    required this.statsAnimationController,
    required this.bottomBarPaneAnimationController,
  });

  final AnimationController appBarAnimationController;
  final AnimationController headerAnimationController;
  final AnimationController statsAnimationController;
  final AnimationController bottomBarPaneAnimationController;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Container(
              // margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.white,
                    Color(0xFFA5957E),
                  ],
                ),
              ),
            ),
          ),
          SafeArea(
            bottom: false,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      HomeCustomAppBar(
                          animationController:
                              widget.appBarAnimationController),
                      const SizedBox(height: 20),
                      HomeHeader(
                        animationController: widget.headerAnimationController,
                      ),
                      const SizedBox(height: 40),
                      StatsCards(
                        animationController: widget.statsAnimationController,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          ValueListenableBuilder(
              valueListenable: showBottomBarPane,
              builder: (context, value, child) {
                return AnimatedPositioned(
                  duration: const Duration(milliseconds: 500),
                  bottom: value ? 0 : -MediaQuery.sizeOf(context).height,
                  left: 0,
                  right: 0,
                  height: Platform.isAndroid
                      ? MediaQuery.sizeOf(context).height * 0.72
                      : MediaQuery.sizeOf(context).height * 0.7,
                  child: HomeBottomBarPane(
                      animationController:
                          widget.bottomBarPaneAnimationController),
                );
              })
        ],
      ),
    );
  }
}
