import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:moniepoint_test/gen/assets.gen.dart';

class HomeCustomAppBar extends StatefulWidget {
  const HomeCustomAppBar({
    super.key,
    required this.animationController,
  });

  final AnimationController animationController;

  @override
  State<HomeCustomAppBar> createState() => _HomeCustomAppBarState();
}

class _HomeCustomAppBarState extends State<HomeCustomAppBar> {
  late AnimationController _animationController;
  late Animation<double> _sizeAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = widget.animationController;

    _sizeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.ease,
      ),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.7, 1.0, curve: Curves.easeIn),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: SizeTransition(
            sizeFactor: _sizeAnimation,
            axis: Axis.horizontal,
            child: Container(
              padding: const EdgeInsets.symmetric(
                vertical: 15,
                horizontal: 20,
              ),
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: Row(
                  children: [
                    const Icon(
                      Iconsax.location5,
                      color: Color(0xFFA5957E),
                    ),
                    const SizedBox(width: 5),
                    Text(
                      'Saint Petersburg',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: const Color(0xFFA5957E),
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        const Spacer(),
        ScaleTransition(
          scale: _animationController,
          child: CircleAvatar(
            backgroundColor: const Color(0xFFF98C12),
            backgroundImage: Assets.images.user.provider(),
          ),
        ),
      ],
    );
  }
}
