import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:moniepoint_test/core/core.dart';
import 'package:moniepoint_test/core/widgets/widgets.dart';
import 'package:moniepoint_test/gen/assets.gen.dart';
import 'package:moniepoint_test/presentation/presentation.dart';

class BottomBarPage extends StatefulWidget {
  const BottomBarPage({super.key});

  @override
  State<BottomBarPage> createState() => _BottomBarPageState();
}

class _BottomBarPageState extends State<BottomBarPage>
    with TickerProviderStateMixin {
  int _currentIndex = 2;

  late AnimationController _searchAnimationController;

  @override
  void initState() {
    super.initState();

    _searchAnimationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1000));
  }

  @override
  void dispose() {
    _searchAnimationController.dispose();
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
                const HomePage(),
                const EmptyPage(
                  title: 'Favourites',
                ),
                const EmptyPage(title: 'Profile'),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
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
