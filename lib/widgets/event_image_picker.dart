import 'package:flutter/material.dart';
import 'dart:io';

import 'package:image_picker/image_picker.dart';
class EventImagePicker extends StatefulWidget {
  final void Function(File pickedImage) onPickImage;
  const EventImagePicker({super.key, required this.onPickImage});

  @override
  State<EventImagePicker> createState() => _EventImagePickerState();
}

class _EventImagePickerState extends State<EventImagePicker> {
  File? _pickedImageFile;

  void _pickImage() async {
    final pickedImage = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
      maxWidth: 150,
    );
    if (pickedImage == null) {
      return;
    }
    setState(() {
      _pickedImageFile = File(pickedImage.path);
    });

    widget.onPickImage(_pickedImageFile!);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Container(
        width: double.maxFinite,
        height: 200,
        //Rectangular container with dotted border
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(5),
        ),
        child: _pickedImageFile == null ? Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton.icon(
                onPressed: _pickImage,
                icon: const Icon(Icons.image),
                label: Text(
                  'Add Image',
                  style: TextStyle(color: Theme.of(context).colorScheme.primary),
                ),
              )
            ],
          ),
        )
        : Image.file(_pickedImageFile!, fit: BoxFit.cover,),
      ),
    );
  }
}
