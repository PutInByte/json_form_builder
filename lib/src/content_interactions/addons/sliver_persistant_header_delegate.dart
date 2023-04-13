import 'package:flutter/material.dart';

class MyHeaderDelegate extends SliverPersistentHeaderDelegate {
  final double expandedHeight;
  final double minHeight;
  final Widget child;

  MyHeaderDelegate({
    required this.expandedHeight,
    required this.minHeight,
    required this.child,
  });

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) => SizedBox.expand(child: child);

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => minHeight;

  @override
  bool shouldRebuild(MyHeaderDelegate oldDelegate) {
    return expandedHeight != oldDelegate.expandedHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}
