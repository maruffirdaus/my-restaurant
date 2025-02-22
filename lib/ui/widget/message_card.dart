import 'package:flutter/material.dart';

class MessageCard extends StatelessWidget {
  final Widget message;
  final Widget child;

  const MessageCard({
    super.key,
    required this.message,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(28),
      ),
      width: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          DefaultTextStyle(
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
            textAlign: TextAlign.center,
            child: message,
          ),
          const SizedBox(
            height: 24,
          ),
          SizedBox(width: double.infinity, child: child),
        ],
      ),
    );
  }
}
