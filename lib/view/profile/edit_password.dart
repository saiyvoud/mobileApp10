import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobileapp/provider/auth_provider.dart';
import 'package:provider/provider.dart';

class EditPassword extends StatefulWidget {
  final String image;
  const EditPassword({super.key, required this.image});

  @override
  State<EditPassword> createState() => _EditPasswordState();
}

class _EditPasswordState extends State<EditPassword> {
  File? filename = null;



clearText(AuthProvider authProvider){
 authProvider.oldPassword.clear(); 
 authProvider.newPassword.clear();
 authProvider.comfirmPassword.clear();
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("ແກ້ໄຂຂໍ້ມູນ"), centerTitle: true),
        body: Consumer<AuthProvider>(builder: (context, authProvider, child) {
          if (authProvider.loading == true) {
            return Center(child: CircularProgressIndicator());
          }
          return Form(
            key: authProvider.formKeyChangePassword,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    SizedBox(height: 10),
                    Center(
                      child: InkWell(
                        onTap: () {},
                        child: Container(
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(100)),
                            child: filename == null
                                ? Center(
                                    child: widget.image == "" ||
                                            widget.image.isEmpty
                                        ? Icon(Icons.person)
                                        : InkWell(
                                            onTap: () {},
                                            child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(60),
                                                child: Image.network(
                                                  widget.image,
                                                  fit: BoxFit.cover,
                                                )),
                                          ),
                                  )
                                : InkWell(
                                    onTap: () {},
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.circular(60),
                                        child: Image.file(
                                          filename!,
                                          fit: BoxFit.cover,
                                        )),
                                  )),
                      ),
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: authProvider.oldPassword,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "password",
                        prefixIcon: Icon(
                          Icons.call,
                          color: Colors.indigo,
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "password is required";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: authProvider.newPassword,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "new password",
                        prefixIcon: Icon(
                          Icons.call,
                          color: Colors.indigo,
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "newpassword is required";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: authProvider.comfirmPassword,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "comfrim password",
                        prefixIcon: Icon(
                          Icons.call,
                          color: Colors.indigo,
                        ),
                      ),
                      validator: (value) {
                        if (!value!.contains(authProvider.newPassword.text)) {
                          return "password not match";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    Container(
                      height: 50,
                      child: TextButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateColor.resolveWith(
                                  (states) => Colors.indigo)),
                          onPressed: () async {
                            if (authProvider.formKeyChangePassword.currentState!
                                .validate()) {
                              await authProvider.changePassword();
                              if (authProvider.success == true) {
                                clearText(authProvider);
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
            ),
          );
        }));
  }
}
