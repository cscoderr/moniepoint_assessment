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
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = widget.animationController;

    _fadeAnimation = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
    );

    _slideAnimation =
        Tween(begin: const Offset(0, 1), end: Offset.zero).animate(
      CurvedAnimation(
          parent: _animationController,
          curve: const Interval(0.3, 1.0, curve: Curves.ease)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FadeTransition(
          opacity: _fadeAnimation,
          child: Text(
            'Hi, Marina',
            style: textTheme.bodyLarge?.copyWith(
              color: const Color(0xFFA5957E),
              fontSize: 22,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        SlideTransition(
          position: _slideAnimation,
          child: Padding(
            padding: const EdgeInsets.only(right: 40),
            child: Text(
              "let's select your perfect place",
              style: textTheme.headlineLarge?.copyWith(
                fontSize: 35,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
