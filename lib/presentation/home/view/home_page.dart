import 'package:flutter/material.dart';
import 'package:moniepoint_test/gen/assets.gen.dart';
import 'package:moniepoint_test/presentation/home/home.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late AnimationController _appBarAnimationController;
  late AnimationController _headerAnimationController;
  late AnimationController _statsAnimationController;

  @override
  void initState() {
    _appBarAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..forward();

    _appBarAnimationController
        .addStatusListener(_appBarAnimationStatusListener);

    _headerAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    _headerAnimationController
        .addStatusListener(_headerAnimationStatusListener);

    _statsAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    super.initState();
  }

  void _appBarAnimationStatusListener(AnimationStatus status) {
    if (status == AnimationStatus.completed ||
        status == AnimationStatus.dismissed) {
      _headerAnimationController.forward();
    }
  }

  void _headerAnimationStatusListener(AnimationStatus status) {
    if (status == AnimationStatus.completed ||
        status == AnimationStatus.dismissed) {
      _statsAnimationController.forward();
    }
  }

  @override
  void dispose() {
    _headerAnimationController.dispose();
    _appBarAnimationController.dispose();
    _statsAnimationController.dispose();
    super.dispose();
  }

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
                          animationController: _appBarAnimationController),
                      const SizedBox(height: 20),
                      HomeHeader(
                        animationController: _headerAnimationController,
                      ),
                      const SizedBox(height: 40),
                      StatsCards(
                        animationController: _statsAnimationController,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 40),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(30)),
                    ),
                    child: Column(
                      children: [
                        ApartmentCard(
                          imageProvider: Assets.images.house1.provider(),
                          address: 'Gladkova St., 25',
                        ),
                        const SizedBox(height: 20),
                        if (1 == 2)
                          Row(
                            children: [
                              Expanded(
                                child: ApartmentCard(
                                  imageProvider:
                                      Assets.images.house1.provider(),
                                  address: 'Gladkova St., 25',
                                ),
                              ),
                              const SizedBox(height: 20),
                              Expanded(
                                child: ApartmentCard(
                                  imageProvider:
                                      Assets.images.house1.provider(),
                                  address: 'Gladkova St., 25',
                                ),
                              ),
                            ],
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
