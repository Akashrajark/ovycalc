import 'package:flutter/material.dart';

import '../util/value.dart';

class CustomToggleButton extends StatelessWidget {
  final String text;
  final Function() ontap;
  final bool isActive;
  const CustomToggleButton({
    super.key,
    required this.text,
    required this.ontap,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: SizedBox(
        width: MediaQuery.of(context).size.width / 2.3,
        child: Material(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: isActive
                ? BorderSide.none
                : const BorderSide(
                    color: Colors.black26,
                    width: 2,
                  ),
          ),
          color: isActive ? primaryColor : secondaryTextColor,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: isActive ? secondaryTextColor : primaryTextColor,
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ),
        ),
      ),
    );
  }
}
