import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerWidget extends StatefulWidget {
  const ImagePickerWidget({super.key});

  @override
  State<ImagePickerWidget> createState() => _ImagePickerWidgetState();
}

class _ImagePickerWidgetState extends State<ImagePickerWidget> {
  File? file;
  Future<File?> pickImage() async {
    try {
      final pick = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pick == null) return null;
      var image = File(pick.path);
      return image;
    } catch (e) {
      return null;
    }
  }

  Future<File?> pickCamera() async {
    try {
      final pick = await ImagePicker().pickImage(source: ImageSource.camera);
      if (pick == null) return null;
      var image = File(pick.path);
      return image;
    } catch (e) {
      return null;
    }
  }

  Future<CroppedFile?> cropfile(File file) async {
    try {
      CroppedFile? croppedFile = await ImageCropper().cropImage(
        sourcePath: file.path,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9
        ],
        uiSettings: [
          AndroidUiSettings(
              toolbarTitle: 'Cropper',
              toolbarColor: Colors.deepOrange,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.original,
              lockAspectRatio: false),
          IOSUiSettings(
            title: 'Cropper',
          ),
          WebUiSettings(
            context: context,
          ),
        ],
      );
      return croppedFile;
    } catch (e) {
      // TODO
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade800,
        leading: Icon(Icons.menu),
        //centerTitle: true,
        title: Row(
          children: [
            Image.network(
              'https://www.searchenginejournal.com/wp-content/uploads/2022/06/image-search-1600-x-840-px-62c6dc4ff1eee-sej.png',
              height: 30,
            ),
            SizedBox(width: 10),
            Text(
              "Welcome to Course",
              style: TextStyle(fontSize: 15),
            )
          ],
        ),
        actions: [
          Icon(Icons.notifications),
          SizedBox(width: 20),
          Icon(Icons.shopping_cart),
          SizedBox(width: 20),
        ],
      ),
      body: Column(
        children: [
          SizedBox(height: 50),
          Container(
            height: 150,
            width: 150,
            decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(10)),
            child: Center(
              child: file == null
                  ? Icon(
                      Icons.photo,
                      size: 32,
                    )
                  : Image.file(
                      file!,
                      fit: BoxFit.cover,
                      height: 150,
                      width: 150,
                    ),
            ),
          ),
          SizedBox(height: 20),
          Center(
            child: TextButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateColor.resolveWith(
                        (states) => Colors.green)),
                onPressed: () {
                  showDialogBox(context);
                },
                child: Text(
                  "ອັບໂຫລດຮູບພາບ",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                )),
          ),
        ],
      ),
    );
  }

  void showDialogBox(context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("ອັບໂຫລດຮູບພາບ"),
            content: Row(children: [
              Icon(Icons.camera_alt),
              TextButton(
                  onPressed: () async {
                    file = await pickCamera();
                    if (file == null) return null;
                    final crop = await cropfile(file!);
                    final image = File(crop!.path);
                    setState(() {
                      file = image;
                    });
                  },
                  child: Text(
                    "ກ້ອງຖ່າຍພາບ",
                    style: TextStyle(color: Colors.black),
                  )),
              Spacer(),
              Icon(Icons.photo),
              TextButton(
                  onPressed: () async {
                    file = await pickCamera();
                    if (file == null) return null;
                    final crop = await cropfile(file!);
                    final image = File(crop!.path);
                    setState(() {
                      file = image;
                    });
                  },
                  child: Text(
                    "ເລືອກຮູບພາບ",
                    style: TextStyle(color: Colors.black),
                  ))
            ]),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Close",
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ))
            ],
          );
        });
  }
}
