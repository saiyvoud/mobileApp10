import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobileapp/provider/auth_provider.dart';
import 'package:provider/provider.dart';

class EditProfile extends StatefulWidget {
  final String image;
  const EditProfile({super.key, required this.image});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  File? filename = null;
  Future<File?> pickGallery({required BuildContext context}) async {
    try {
      var xImage = await ImagePicker().pickImage(
        source: ImageSource.gallery,
      );
      if (xImage == null) {}
      var image = File(xImage!.path);
      return image;
    } catch (e) {
      print('Faild to pick image: ${e}');
      return null;
    }
  }

  Future<File?> pickCamera({required BuildContext context}) async {
    try {
      var xImage = await ImagePicker().pickImage(
        source: ImageSource.camera,
      );
      if (xImage == null) {}
      var image = File(xImage!.path);
      return image;
    } catch (e) {
      print('Faild to pick image: ${e}');
      return null;
    }
  }

  void _showPickImage(AuthProvider authProvider) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("ເລືອກຮູບພາບ"),
            content: Row(
              children: [
                InkWell(
                  onTap: () async {
                    filename = await pickCamera(context: context);
                    await authProvider.updateProfileImage(filename: filename!);
                    if (authProvider.success == true) {
                      AwesomeDialog(
                        context: context,
                        dialogType: DialogType.success,
                        animType: AnimType.bottomSlide,
                        title: 'ສຳເລັດ',
                        desc: 'ແກ້ໄຂຮູບພາບສຳເລັດ',
                        btnCancelOnPress: () {},
                        btnOkOnPress: () {},
                      )..show();
                    } else {
                      AwesomeDialog(
                        context: context,
                        dialogType: DialogType.error,
                        animType: AnimType.rightSlide,
                        title: 'ຜິດພາດ',
                        desc: 'ແກ້ໄຂຂໍ້ມູນບຜິດພາດ',
                        btnCancelOnPress: () {},
                        btnOkOnPress: () {},
                      )..show();
                    }
                  },
                  child: Row(
                    children: [
                      Icon(Icons.camera_alt),
                      SizedBox(width: 10),
                      Text("ຖ່າຍຮູບ"),
                    ],
                  ),
                ),
                Spacer(),
                InkWell(
                  onTap: () async {
                    filename = await pickGallery(context: context);
                    await authProvider.updateProfileImage(filename: filename!);
                    if (authProvider.success == true) {
                      AwesomeDialog(
                        context: context,
                        dialogType: DialogType.success,
                        animType: AnimType.bottomSlide,
                        title: 'ສຳເລັດ',
                        desc: 'ແກ້ໄຂຮູບພາບສຳເລັດ',
                        btnCancelOnPress: () {},
                        btnOkOnPress: () {},
                      )..show();
                    } else {
                      AwesomeDialog(
                        context: context,
                        dialogType: DialogType.error,
                        animType: AnimType.rightSlide,
                        title: 'ຜິດພາດ',
                        desc: 'ແກ້ໄຂຂໍ້ມູນບຜິດພາດ',
                        btnCancelOnPress: () {},
                        btnOkOnPress: () {},
                      )..show();
                    }
                  },
                  child: Row(
                    children: [
                      Icon(Icons.photo),
                      SizedBox(width: 10),
                      Text("ຮູບພາບ"),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }

  @override
  void initState() {
    super.initState();
    Provider.of<AuthProvider>(context, listen: false)..getProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("ແກ້ໄຂຂໍ້ມູນ"), centerTitle: true),
        body: Consumer<AuthProvider>(builder: (context, authProvider, child) {
          if (authProvider.loading == true) {
            return Center(child: CircularProgressIndicator());
          }
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  SizedBox(height: 10),
                  Center(
                    child: InkWell(
                      onTap: () {
                        _showPickImage(authProvider);
                      },
                      child: Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(100)),
                          child: filename == null
                              ? Center(
                                  child:
                                      widget.image == "" || widget.image.isEmpty
                                          ? Icon(Icons.person)
                                          : InkWell(
                                            onTap: (){
                                                  _showPickImage(authProvider);
                                            },
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.circular(60),
                                              child: Image.network(widget.image,fit: BoxFit.cover,)),
                                          ),
                                )
                              : InkWell(
                                onTap: (){
                                  _showPickImage(authProvider);
                                },
                                child: ClipRRect(
                                   borderRadius: BorderRadius.circular(60),
                                  child: Image.file(filename!,fit: BoxFit.cover,)),
                              )),
                    ),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    //controller: auth.username,
                    initialValue: authProvider.userModel.username,
                    onChanged: (value) => authProvider.username.text = value,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "username",
                      prefixIcon: Icon(
                        Icons.person,
                        color: Colors.indigo,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    initialValue: authProvider.userModel.phone.toString(),
                    onChanged: (value) => authProvider.phone.text = value,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "20xxxxxxxx",
                      prefixIcon: Icon(
                        Icons.call,
                        color: Colors.indigo,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    // controller: auth.email,
                    enabled: false,
                    initialValue: authProvider.userModel.email,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "email@gmail.com",
                      prefixIcon: Icon(
                        Icons.email,
                        color: Colors.indigo,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    height: 50,
                    child: TextButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateColor.resolveWith(
                                (states) => Colors.indigo)),
                        onPressed: () async {
                          await authProvider.updateProfile();
                          if (authProvider.success == true) {
                            AwesomeDialog(
                              context: context,
                              dialogType: DialogType.success,
                              animType: AnimType.bottomSlide,
                              title: 'ສຳເລັດ',
                              desc: 'ແກ້ໄຂຂໍ້ມູນສຳເລັດ',
                              btnCancelOnPress: () {},
                              btnOkOnPress: () {},
                            )..show();
                          } else {
                            AwesomeDialog(
                              context: context,
                              dialogType: DialogType.error,
                              animType: AnimType.rightSlide,
                              title: 'ຜິດພາດ',
                              desc: 'ແກ້ໄຂຂໍ້ມູນບຜິດພາດ',
                              btnCancelOnPress: () {},
                              btnOkOnPress: () {},
                            )..show();
                          }
                        },
                        child: Center(
                          child: Text(
                            "ແກ້ໄຂຂໍ້ມູນ",
                            style: TextStyle(color: Colors.white),
                          ),
                        )),
                  )
                ],
              ),
            ),
          );
        }));
  }
}
