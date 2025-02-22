import 'package:flutter/material.dart';

class ContentCard extends StatelessWidget {
  final EdgeInsetsGeometry? padding;
  final double? width;
  final double? height;
  final Widget child;

  const ContentCard({
    super.key,
    this.padding,
    this.width,
    this.height,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(28),
      ),
      width: width,
      height: height,
      child: child,
    );
  }
}
