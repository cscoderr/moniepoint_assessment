import 'dart:ui';

import 'package:flutter/material.dart';

class ApartmentCard extends StatelessWidget {
  const ApartmentCard({
    super.key,
    required this.address,
    required this.imageProvider,
    this.onTap,
  });

  final ImageProvider imageProvider;
  final String address;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      child: Stack(
        children: [
          Positioned.fill(
            child: Container(
              height: 250,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            right: 20,
            left: 20,
            child: _AddressTile(
              address: address,
              onTap: onTap,
            ),
          )
        ],
      ),
    );
  }
}

class _AddressTile extends StatelessWidget {
  const _AddressTile({
    super.key,
    required this.address,
    this.onTap,
  });

  final String address;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(50),
      child: ColoredBox(
        color: Theme.of(context).colorScheme.secondary.withOpacity(0.5),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 50, sigmaY: 50),
          child: Padding(
            padding: const EdgeInsets.all(3),
            child: Row(
              children: [
                Expanded(
                  child: Align(
                    child: Text(
                      address,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                  ),
                ),
                InkResponse(
                  onTap: onTap,
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    child: const Icon(Icons.keyboard_arrow_right),
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
