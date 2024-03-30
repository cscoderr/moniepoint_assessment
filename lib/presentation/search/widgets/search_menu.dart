import 'package:flutter/material.dart';

class SearchMenu extends StatelessWidget {
  const SearchMenu({
    super.key,
    required this.items,
    this.currentIndex = 0,
    this.onTap,
  });

  final List<SearchMenuItem> items;
  final int currentIndex;
  final ValueChanged<int>? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: const Color(0xFFFAF2E6),
      ),
      child: DefaultTextStyle(
        style: Theme.of(context).textTheme.bodyLarge!.copyWith(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: items.asMap().entries.map((e) {
            return Padding(
              padding:
                  EdgeInsets.only(bottom: e.key != items.length - 1 ? 20 : 0),
              child: _SearchMenuTile(
                item: e.value,
                selected: e.key == currentIndex,
                onTap: () => onTap?.call(e.key),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

class _SearchMenuTile extends StatelessWidget {
  const _SearchMenuTile({
    super.key,
    required this.item,
    this.selected = false,
    this.onTap,
  });

  final SearchMenuItem item;
  final bool selected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            item.icon,
            color: selected
                ? Theme.of(context).primaryColor
                : const Color(0xFF77736E),
          ),
          const SizedBox(width: 15),
          Text(
            item.text,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontSize: 18,
                  color: selected
                      ? Theme.of(context).primaryColor
                      : const Color(0xFF77736E),
                  letterSpacing: -0.5,
                ),
          ),
        ],
      ),
    );
  }
}

class SearchMenuItem {
  const SearchMenuItem({
    required this.icon,
    required this.text,
  });

  final IconData icon;
  final String text;
}
