import 'package:flutter/material.dart';

class HomeHeader extends StatefulWidget {
  const HomeHeader({
    super.key,
    required this.animationController,
  });

  final AnimationController animationController;

  @override
  State<HomeHeader> createState() => _HomeHeaderState();
}

class _HomeHeaderState extends State<HomeHeader> {
  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;
  late Animation<Offset> _slideAnimation2;
  late Animation<double> _fadeAnimation;
  late Animation<double> _firstTextFadeAnimation;
  late Animation<double> _secondTextFadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = widget.animationController;

    _fadeAnimation = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _slideAnimation =
        Tween(begin: const Offset(0, 1.5), end: Offset.zero).animate(
      CurvedAnimation(
          parent: _animationController,
          curve: const Interval(0.45, 1.0, curve: Curves.ease)),
    );
    _firstTextFadeAnimation = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
          parent: _animationController,
          curve: const Interval(0.3, 1.0, curve: Curves.ease)),
    );
    _slideAnimation2 =
        Tween(begin: const Offset(0, 1.5), end: Offset.zero).animate(
      CurvedAnimation(
          parent: _animationController,
          curve: const Interval(0.55, 1.0, curve: Curves.ease)),
    );
    _secondTextFadeAnimation = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
          parent: _animationController,
          curve: const Interval(0.5, 1.0, curve: Curves.ease)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return AnimatedBuilder(
        animation: Listenable.merge([_slideAnimation, _slideAnimation2]),
        builder: (context, child) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              FadeTransition(
                opacity: _fadeAnimation,
                child: Text(
                  'Hi, Marina',
                  style: textTheme.bodyLarge?.copyWith(
                    color: const Color(0xFFA5957E),
                    fontSize: 24,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              FadeTransition(
                opacity: _firstTextFadeAnimation,
                child: SlideTransition(
                  position: _slideAnimation,
                  child: Text(
                    "let's select your",
                    style: textTheme.headlineLarge?.copyWith(
                      fontSize: 35,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              FadeTransition(
                opacity: _firstTextFadeAnimation,
                child: SlideTransition(
                  position: _slideAnimation2,
                  child: Text(
                    "perfect place",
                    style: textTheme.headlineLarge?.copyWith(
                      fontSize: 35,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
            ],
          );
        });
  }
}
