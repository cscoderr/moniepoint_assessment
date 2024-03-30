import 'package:flutter/material.dart';

class LazyIndexedStack extends StatefulWidget {
  const LazyIndexedStack({
    super.key,
    this.index = 0,
    this.children = const [],
  });

  final int index;

  final List<Widget> children;

  @override
  State<LazyIndexedStack> createState() => _LazyIndexedStackState();
}

class _LazyIndexedStackState extends State<LazyIndexedStack> {
  late final List<bool> _activatedChildren;

  @override
  void initState() {
    super.initState();
    _activatedChildren = List.generate(
      widget.children.length,
      (i) => i == widget.index,
    );
  }

  @override
  void didUpdateWidget(LazyIndexedStack oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.index != widget.index) _activateChild(widget.index);
  }

  void _activateChild(int? index) {
    if (index == null) return;
    if (!_activatedChildren[index]) _activatedChildren[index] = true;
  }

  List<Widget> get children {
    return List.generate(
      widget.children.length,
      (i) {
        return _activatedChildren[i]
            ? widget.children[i]
            : const SizedBox.shrink();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return IndexedStack(
      sizing: StackFit.loose,
      index: widget.index,
      children: children,
    );
  }
}
