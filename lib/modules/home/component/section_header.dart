import 'package:flutter/material.dart';

import '../../../utils/constants.dart';


class SectionHeader extends StatelessWidget {
  const SectionHeader({
    Key? key,
    this.color,
    this.onTap,
    required this.headerText,
  }) : super(key: key);
  final Color? color;
  final String headerText;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          headerText,
          style: TextStyle(
              fontSize: 18,
              color: color,
              height: 1.5,
              fontWeight: FontWeight.w600),
        ),
        InkWell(
          onTap: onTap,
          child: Container(
            // color: iconGreyColor,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: const Text(
              'See all',
              style: TextStyle(fontSize: 16, color: redColor, height: 1.625),
            ),
          ),
        ),
      ],
    );
  }
}
