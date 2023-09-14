import 'dart:io';

import 'package:flutter/material.dart';

class SelectedItem extends StatelessWidget {
  final double amount;
  final int count;
  final String name, image;
  final Function() onTap;
  const SelectedItem({
    super.key,
    required this.count,
    required this.amount,
    required this.name,
    required this.image,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Material(
          borderRadius: BorderRadius.circular(10),
          color: Colors.amberAccent,
          child: SizedBox(
            width: 140,
            child: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text("$count"),
                      Text(name),
                      const Icon(
                        Icons.remove,
                        color: Colors.red,
                      ),
                    ],
                  ),
                ),
                Image.file(
                  File(image),
                  width: 140,
                  height: 120,
                  fit: BoxFit.cover,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
