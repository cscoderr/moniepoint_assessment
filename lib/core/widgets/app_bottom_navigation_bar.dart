import 'package:flutter/material.dart';

/// Custom app bottom navigation bar
/// [currentIndex] is default to zero
/// [items] is required and must not be empty
class AppBottomNavigationBar extends StatelessWidget {
  /// Custom app bottom navigation bar
  /// [currentIndex] is default to zero
  /// [items] is required and must not be empty
  const AppBottomNavigationBar({
    super.key,
    this.currentIndex = 0,
    required this.items,
    this.onChanged,
  }) : assert(items.length >= 2, 'Items must contain at least two(2) item');

  ///CurrentIndex is used to change the active item
  final int currentIndex;

  ///Items is used to generate the list of the
  ///required items for the bottom navigation bar
  final List<AppBottomNavigationBarItem> items;

  ///
  final ValueChanged<int>? onChanged;

  @override
  Widget build(BuildContext context) {
    final tiles = items.asMap().entries.map((e) {
      return _AppBottomNavigationTile(
        item: e.value,
        selected: e.key == currentIndex,
        onTap: () => onChanged?.call(e.key),
      );
    }).toList();

    return SafeArea(
      child: Material(
        type: MaterialType.transparency,
        child: Container(
          height: kBottomNavigationBarHeight + 10,
          margin: const EdgeInsets.symmetric(horizontal: 60),
          padding: const EdgeInsets.symmetric(horizontal: 3),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.background,
            borderRadius: BorderRadius.circular(50),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: tiles,
          ),
        ),
      ),
    );
  }
}

class _AppBottomNavigationTile extends StatelessWidget {
  const _AppBottomNavigationTile({
    super.key,
    required this.item,
    this.selected = false,
    this.onTap,
  });

  final AppBottomNavigationBarItem item;
  final bool selected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    Widget tile = AnimatedContainer(
      duration: const Duration(milliseconds: 350),
      padding: selected ? const EdgeInsets.all(15) : const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color:
            selected ? Theme.of(context).primaryColor : const Color(0xFF1A1A18),
        shape: BoxShape.circle,
      ),
      child: IconTheme(
        data: IconThemeData(
          color: Theme.of(context).colorScheme.onBackground,
        ),
        child: item.icon,
      ),
    );

    tile = InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(50),
      child: tile,
    );

    return Expanded(child: tile);
  }
}

///Custom app bottom navigation bar item used
///to generate the bottom navigation bar children
///[icon] is required
class AppBottomNavigationBarItem {
  ///Custom app bottom navigation bar item used
  ///to generate the bottom navigation bar children
  ///[icon] is required
  const AppBottomNavigationBarItem({
    required this.icon,
  });
  final Widget icon;
}
