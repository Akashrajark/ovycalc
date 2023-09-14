import 'package:flutter/material.dart';

import '../util/value.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Function() onTap;
  final Color color;
  const CustomButton({
    super.key,
    required this.text,
    required this.onTap,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: MediaQuery.of(context).size.width / 2.3,
        child: Material(
          borderRadius: BorderRadius.circular(10),
          color: color,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                    color: secondaryTextColor,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
        ),
      ),
    );
  }
}
