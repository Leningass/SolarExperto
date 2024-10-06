
import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Upload extends StatefulWidget {
  Upload({
    Key? key,
    required this.onSelected,
    required this.initialValue,
  }): super(key: key);
  Function onSelected;
  String? initialValue;
  @override
  State<Upload> createState() => _UploadState();
}

class _UploadState extends State<Upload> {
  File? selectedImage = null;

  void _handleCapture() {
    ImagePicker()
        .pickImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    )
        .then((pickedImage) {
      if (pickedImage != null) {
        setState(() {
          selectedImage = File(pickedImage.path);
        });
        widget.onSelected(pickedImage.path);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    if (widget.initialValue != null) {
      selectedImage = File(widget.initialValue!);
      widget.onSelected(widget.initialValue!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleCapture,
      child: Container(
        margin: EdgeInsets.only(top: 20),
        height: 60,
        child: DottedBorder(
          color: Colors.grey,
          strokeWidth: 2,
          dashPattern: [5, 5, 5, 5],
          radius: Radius.circular(12),
          child: Center(
            child: selectedImage == null
                ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.photo,
                  color: Colors.grey,
                ),
                Text(
                  'Image',
                  style: TextStyle(color: Colors.grey[600], fontSize: 15),
                ),
              ],
            )
                : Image.file(selectedImage!),
          ),
        ),
      ),
    );
  }
}
