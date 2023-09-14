import 'dart:io';

import 'package:calc/util/value.dart';
import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final String text, image;
  final Function() ontap;
  const CustomCard({
    super.key,
    required this.text,
    required this.image,
    required this.ontap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Material(
          borderRadius: BorderRadius.circular(10),
          color: primaryColor,
          child: SizedBox(
            width: 140,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.file(
                  File(image),
                  width: 140,
                  height: 120,
                  fit: BoxFit.cover,
                ),
                Text(
                  text,
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: secondaryTextColor,
                      ),
                ),
                const SizedBox(
                  height: 2,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
