import 'package:flutter/material.dart';
import 'package:moniepoint_test/gen/assets.gen.dart';
import 'package:moniepoint_test/presentation/home/home.dart';

class HomeBottomBarPane extends StatefulWidget {
  const HomeBottomBarPane({
    super.key,
    required this.animationController,
  });

  final AnimationController animationController;

  @override
  State<HomeBottomBarPane> createState() => _HomeBottomBarPaneState();
}

class _HomeBottomBarPaneState extends State<HomeBottomBarPane> {
  late Animation<double> _sizeAnimation;
  late Animation<double> _subSizeAnimation;
  late Animation<double> _fadeAnimation;
  late Animation<double> _subFadeAnimation;

  @override
  void initState() {
    super.initState();

    _sizeAnimation = Tween<double>(begin: 0, end: 1.0).animate(
      CurvedAnimation(
        parent: widget.animationController,
        curve: Curves.fastOutSlowIn,
      ),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: widget.animationController,
        curve: const Interval(0.5, 1.0, curve: Curves.easeIn),
      ),
    );

    _subFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: widget.animationController,
        curve: const Interval(0.7, 1.0, curve: Curves.easeIn),
      ),
    );

    _subSizeAnimation = Tween<double>(begin: 0, end: 1.0).animate(
      CurvedAnimation(
        parent: widget.animationController,
        curve: const Interval(
          0.5,
          1.0,
          curve: Curves.fastOutSlowIn,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: Listenable.merge([_sizeAnimation, _subSizeAnimation]),
        builder: (context, child) {
          return Container(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
            ),
            clipBehavior: Clip.antiAlias,
            child: SingleChildScrollView(
              padding: EdgeInsets.only(bottom: kBottomNavigationBarHeight + 50),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 250,
                    child: ApartmentCard(
                      imageProvider: Assets.images.house1.provider(),
                      address: 'Gladkova St., 25',
                      sizeAnimation: _sizeAnimation,
                      fadeAnimation: _fadeAnimation,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 420,
                          child: ApartmentCard(
                            imageProvider: Assets.images.house1.provider(),
                            address: 'Gladkova St., 25',
                            isSub: true,
                            sizeAnimation: _subSizeAnimation,
                            fadeAnimation: _fadeAnimation,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 200,
                              child: ApartmentCard(
                                imageProvider: Assets.images.house1.provider(),
                                address: 'Trefoleva St., 43',
                                isSub: true,
                                sizeAnimation: _subSizeAnimation,
                                fadeAnimation: _fadeAnimation,
                              ),
                            ),
                            const SizedBox(height: 10),
                            SizedBox(
                              height: 200,
                              child: ApartmentCard(
                                imageProvider: Assets.images.house1.provider(),
                                address: 'Gladkova St., 25',
                                isSub: true,
                                sizeAnimation: _subSizeAnimation,
                                fadeAnimation: _fadeAnimation,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }
}
