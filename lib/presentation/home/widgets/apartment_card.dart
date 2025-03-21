import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/material.dart';

class ApartmentCard extends StatelessWidget {
  const ApartmentCard({
    super.key,
    required this.address,
    required this.imageProvider,
    this.isSub = false,
    this.onTap,
    required this.sizeAnimation,
    required this.fadeAnimation,
  });

  final ImageProvider imageProvider;
  final String address;
  final VoidCallback? onTap;
  final bool isSub;
  final Animation<double> sizeAnimation;
  final Animation<double> fadeAnimation;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: DecoratedBox(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: imageProvider,
                fit: BoxFit.cover,
              ),
              borderRadius:
                  isSub ? BorderRadius.circular(20) : BorderRadius.circular(30),
            ),
          ),
        ),
        Positioned(
          bottom: 20,
          right: isSub ? 5 : 20,
          left: isSub ? 5 : 20,
          child: _AddressTile(
            address: address,
            isSub: isSub,
            onTap: onTap,
            sizeAnimation: sizeAnimation,
            fadeAnimation: fadeAnimation,
          ),
        )
      ],
    );
  }
}

class _AddressTile extends StatelessWidget {
  const _AddressTile({
    super.key,
    required this.address,
    this.onTap,
    required this.isSub,
    required this.sizeAnimation,
    required this.fadeAnimation,
  });

  final String address;
  final bool isSub;
  final VoidCallback? onTap;
  final Animation<double> sizeAnimation;
  final Animation<double> fadeAnimation;

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: math.max(sizeAnimation.value, 0.35),
      alignment: Alignment.centerLeft,
      child: Container(
        height: isSub ? 50 : 70,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary.withValues(alpha: 0.5),
          borderRadius: BorderRadius.circular(isSub ? 30 : 50),
        ),
        clipBehavior: Clip.antiAlias,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 50, sigmaY: 50),
          child: Padding(
            padding: const EdgeInsets.all(3),
            child: Row(
              children: [
                const SizedBox(width: 5),
                Expanded(
                  child: FadeTransition(
                    opacity: fadeAnimation,
                    child: Center(
                      child: Text(
                        address,
                        maxLines: 1,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 5),
                InkResponse(
                  onTap: onTap,
                  child: FadeTransition(
                    opacity: fadeAnimation,
                    child: Container(
                      padding: EdgeInsets.all(isSub ? 10 : 20),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      child: const Icon(Icons.keyboard_arrow_right),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
