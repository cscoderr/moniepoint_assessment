import 'dart:io';

import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:moniepoint_test/core/core.dart';
import 'package:moniepoint_test/core/widgets/widgets.dart';
import 'package:moniepoint_test/gen/assets.gen.dart';
import 'package:moniepoint_test/presentation/presentation.dart';

final showBottomBarPane = ValueNotifier(false);

class BottomBarPage extends StatefulWidget {
  const BottomBarPage({super.key});

  @override
  State<BottomBarPage> createState() => _BottomBarPageState();
}

class _BottomBarPageState extends State<BottomBarPage>
    with TickerProviderStateMixin {
  int _currentIndex = 2;

  late AnimationController _searchAnimationController;
  late AnimationController _homeAppBarAnimationController;
  late AnimationController _homeHeaderAnimationController;
  late AnimationController _homeStatsAnimationController;
  late AnimationController _homeBottomBarPaneAnimationController;
  bool showBottomNavigation = false;

  @override
  void initState() {
    _searchAnimationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1000));

    _homeAppBarAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..forward();

    _homeAppBarAnimationController
        .addStatusListener(_appBarAnimationStatusListener);

    _homeHeaderAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    _homeHeaderAnimationController
        .addStatusListener(_headerAnimationStatusListener);

    _homeStatsAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    _homeStatsAnimationController
        .addStatusListener(_homeStatsAnimationStatusListener);

    _homeBottomBarPaneAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    _homeBottomBarPaneAnimationController
        .addStatusListener(_homeBottomPanAnimationStatusListener);

    super.initState();
  }

  void _appBarAnimationStatusListener(AnimationStatus status) {
    if (status == AnimationStatus.completed ||
        status == AnimationStatus.dismissed) {
      _homeHeaderAnimationController.forward();
    }
  }

  void _headerAnimationStatusListener(AnimationStatus status) {
    if (status == AnimationStatus.completed ||
        status == AnimationStatus.dismissed) {
      _homeStatsAnimationController.forward();
    }
  }

  void _homeStatsAnimationStatusListener(AnimationStatus status) {
    if (status == AnimationStatus.completed ||
        status == AnimationStatus.dismissed) {
      showBottomBarPane.value = true;
      Future.delayed(const Duration(milliseconds: 200), () {
        _homeBottomBarPaneAnimationController.forward();
      });
    }
  }

  void _homeBottomPanAnimationStatusListener(AnimationStatus status) {
    if (status == AnimationStatus.completed ||
        status == AnimationStatus.dismissed) {
      setState(() {
        showBottomNavigation = true;
      });
    }
  }

  @override
  void dispose() {
    _homeHeaderAnimationController.dispose();
    _homeAppBarAnimationController.dispose();
    _homeStatsAnimationController.dispose();
    _searchAnimationController.dispose();
    _homeBottomBarPaneAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: LazyIndexedStack(
              index: _currentIndex,
              children: [
                SearchPage(animationController: _searchAnimationController),
                const EmptyPage(title: 'Messages'),
                HomePage(
                  appBarAnimationController: _homeAppBarAnimationController,
                  headerAnimationController: _homeHeaderAnimationController,
                  statsAnimationController: _homeStatsAnimationController,
                  bottomBarPaneAnimationController:
                      _homeBottomBarPaneAnimationController,
                ),
                const EmptyPage(
                  title: 'Favourites',
                ),
                const EmptyPage(title: 'Profile'),
              ],
            ),
          ),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 500),
            bottom: showBottomNavigation ? (Platform.isAndroid ? 20 : 0) : -100,
            left: 0,
            right: 0,
            child: AppBottomNavigationBar(
              currentIndex: _currentIndex,
              onChanged: (value) {
                setState(() {
                  _currentIndex = value;
                });
              },
              items: [
                const AppBottomNavigationBarItem(
                  icon: Padding(
                    padding: EdgeInsets.only(right: 25),
                    child: Icon(Iconsax.search_normal_15),
                  ),
                ),
                const AppBottomNavigationBarItem(icon: Icon(Iconsax.message5)),
                const AppBottomNavigationBarItem(icon: Icon(Iconsax.home5)),
                const AppBottomNavigationBarItem(icon: Icon(Iconsax.heart5)),
                AppBottomNavigationBarItem(
                    icon: Assets.icons.user.svg(
                  colorFilter:
                      const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
