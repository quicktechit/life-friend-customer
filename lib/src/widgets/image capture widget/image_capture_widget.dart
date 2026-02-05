// image_capture_widget.dart

// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/services.dart';
import 'dart:io';

class ImageCaptureWidget extends StatefulWidget {
  final void Function(XFile?) onImageCaptured;
  final String text;
  final IconData icon;

  const ImageCaptureWidget({
    Key? key,
    required this.onImageCaptured,
    required this.text,
    required this.icon,
  }) : super(key: key);

  @override
  _ImageCaptureWidgetState createState() => _ImageCaptureWidgetState();
}

class _ImageCaptureWidgetState extends State<ImageCaptureWidget> {
  XFile? image;

  Future<void> pickPassportImage() async {
    try {
      showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ListTile(
                  leading: Icon(Icons.camera),
                  title: Text('Take a Photo'),
                  onTap: () async {
                    Navigator.pop(context);
                    await captureImage(ImageSource.camera);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.photo),
                  title: Text('Choose from Gallery'),
                  onTap: () async {
                    Navigator.pop(context);
                    await captureImage(ImageSource.gallery);
                  },
                ),
              ],
            ),
          );
        },
      );
    } on PlatformException catch (e) {
      print('Failed to pick passport image: $e');
    }
  }

  Future<void> captureImage(ImageSource source) async {
    final pickedImage = await ImagePicker().pickImage(source: source);
    if (pickedImage == null) return;
    final imageTemp = XFile(pickedImage.path);
    setState(() => image = imageTemp);
    widget.onImageCaptured(image);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: InkWell(
        onTap: pickPassportImage,
        child: Padding(
          padding: const EdgeInsets.only(top: 18.0),
          child: Container(
            height: 150.0,
            width: 150.0,
            child: image == null
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          widget.icon,
                          color: Colors.grey,
                          size: 100.h,
                        ),
                        Text(widget.text),
                      ],
                    ),
                  )
                : CircleAvatar(
                    radius: 75.0,
                    backgroundImage: FileImage(File(image!.path)),
                  ),
          ),
        ),
      ),
    );
  }
}
