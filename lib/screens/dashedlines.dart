import 'package:flutter/material.dart';

class DashedVerticalLine extends StatelessWidget {
  final double height;
  const DashedVerticalLine({super.key, required this.height});

  @override
  Widget build(BuildContext context) {
    const dashHeight = 6.0;
    const dashSpacing = 4.0;
    final dashCount = (height / (dashHeight + dashSpacing)).floor();

    return Column(
      children: List.generate(dashCount, (_) {
        return Padding(
          padding: const EdgeInsets.only(bottom: dashSpacing),
          child: Container(
            width: 2,
            height: dashHeight,
            color: Colors.grey,
          ),
        );
      }),
    );
  }
}
