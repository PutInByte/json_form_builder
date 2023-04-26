import 'package:flutter/material.dart';

class ItemGroupTile extends StatelessWidget {
  final InputBorder? customBorder;
  final VoidCallback? onTap;
  final Widget leading;
  final Widget content;
  final double? size;

  const ItemGroupTile({
    Key? key,
    this.customBorder,
    this.onTap,
    this.size,
    required this.leading,
    required this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget current = Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: this.size ?? kMinInteractiveDimension,
            minWidth: this.size ?? kMinInteractiveDimension,
          ),
          child: leading,
        ),
        Flexible(child: content),
        const SizedBox(width: 15.0),
      ],
    );
    if (onTap != null) {
      current = InkWell(
        customBorder: customBorder,
        onTap: onTap,
        child: current,
      );
    }
    return current;
  }
}
