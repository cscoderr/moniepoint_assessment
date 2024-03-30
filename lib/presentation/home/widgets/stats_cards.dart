import 'package:flutter/material.dart';

class StatsCards extends StatefulWidget {
  const StatsCards({
    super.key,
    required this.animationController,
  });

  final AnimationController animationController;

  @override
  State<StatsCards> createState() => _StatsCardsState();
}

class _StatsCardsState extends State<StatsCards> {
  late AnimationController _animationController;
  late Animation<double> _buyOfferTextAnimation;
  late Animation<double> _rentOfferTextAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = widget.animationController;
    _buyOfferTextAnimation = Tween(begin: 0.0, end: 1034.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
    _rentOfferTextAnimation = Tween(begin: 0.0, end: 2212.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return AnimatedBuilder(
      animation:
          Listenable.merge([_buyOfferTextAnimation, _rentOfferTextAnimation]),
      builder: (context, child) {
        return Row(
          children: [
            Expanded(
              child: ScaleTransition(
                scale: _animationController,
                child: CircleAvatar(
                  radius: 80,
                  backgroundColor: const Color(0xFFF98C12),
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      children: [
                        Text(
                          'BUY',
                          style: textTheme.bodyLarge?.copyWith(
                            color: Colors.white,
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                _formatCount(
                                    _buyOfferTextAnimation.value.toInt()),
                                style: textTheme.bodyLarge?.copyWith(
                                  color: Colors.white,
                                  fontSize: 35,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Text(
                                'offers',
                                style: textTheme.bodyLarge?.copyWith(
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: ScaleTransition(
                scale: _animationController,
                child: Container(
                  height: 160,
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      Text(
                        'RENT',
                        style: textTheme.bodyLarge?.copyWith(
                          color: const Color(0xFFA5957E),
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              _formatCount(
                                  _rentOfferTextAnimation.value.toInt()),
                              style: textTheme.bodyLarge?.copyWith(
                                color: const Color(0xFFA5957E),
                                fontSize: 35,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Text(
                              'offers',
                              style: textTheme.bodyLarge?.copyWith(
                                color: const Color(0xFFA5957E),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  String _formatCount(int count) {
    final thousandPlaceValue = count ~/ 1000;

    return thousandPlaceValue == 0
        ? count.toString()
        : '$thousandPlaceValue ${count.toString().substring(1)}';
  }
}
