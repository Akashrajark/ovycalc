import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class CustomImagePicker extends StatelessWidget {
  final Function() onTap;
  const CustomImagePicker({
    super.key,
    required this.file,
    required this.onTap,
  });

  final PlatformFile? file;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 200,
        child: Material(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: const BorderSide(color: Colors.black26),
          ),
          child: file != null
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.file(
                    File(file!.path!),
                    fit: BoxFit.cover,
                  ),
                )
              : Center(
                  child: Text(
                    "Add Image",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
        ),
      ),
    );
  }
}
