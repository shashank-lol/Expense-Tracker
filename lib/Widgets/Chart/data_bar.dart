import 'package:flutter/material.dart';

class DataBar extends StatelessWidget {
  const DataBar({super.key, required this.height});

  final double height;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: FractionallySizedBox(
        heightFactor: height,
        child: DecoratedBox(
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(8)),
              color: Theme.of(context)
                  .colorScheme
                  .onPrimaryContainer
                  .withOpacity(0.5)),
        ),
      ),
    ));
  }
}
