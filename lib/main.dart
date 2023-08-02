import 'package:flutter/material.dart';
import 'package:mobileapp/view/Banner.dart';
import 'package:mobileapp/view/GridView.dart';
import 'package:mobileapp/view/ListView.dart';
import 'package:mobileapp/view/Stack.dart';
import 'package:mobileapp/view/imagePicker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ImagePickerWidget()
     
    );
  }
}
