import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:mobileapp/provider/auth_provider.dart';
import 'package:provider/provider.dart';

import '../components/bottombar.dart';

class FormRegister extends StatefulWidget {
  const FormRegister({super.key});

  @override
  State<FormRegister> createState() => _FormRegisterState();
}

class _FormRegisterState extends State<FormRegister> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Register"),
          centerTitle: true,
        ),
        body: Consumer<AuthProvider>(
          builder: (context, auth, child) {
            if (auth.loading == true) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return Form(
              key: auth.formKeyRegister,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    children: [
                      SizedBox(height: 20),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(
                          "assets/images/logo.png",
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(height: 20),
                      Text("Create New Account"),
                      SizedBox(height: 10),
                      TextFormField(
                        controller: auth.username,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "username",
                          prefixIcon: Icon(
                            Icons.person,
                            color: Colors.indigo,
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "username is required!";
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        controller: auth.phone,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "20xxxxxxxx",
                          prefixIcon: Icon(
                            Icons.call,
                            color: Colors.indigo,
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "phone is required!";
                          } else if (value.length < 10) {
                            return "phone must 10 than more";
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        controller: auth.email,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "email@gmail.com",
                          prefixIcon: Icon(
                            Icons.email,
                            color: Colors.indigo,
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "email is required!";
                          } else if (!value.contains("@gmail.com")) {
                            return "@gmail.com is required!";
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        controller: auth.password,
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "password",
                          prefixIcon: Icon(
                            Icons.security,
                            color: Colors.indigo,
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "password is required!";
                          } else if (value.length < 6) {
                            return "password must 6 than more";
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        controller: auth.comfirmPassword,
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "comfirm password",
                          prefixIcon: Icon(
                            Icons.security,
                            color: Colors.indigo,
                          ),
                        ),
                        validator: (value) {
                          if (!value!.contains("${auth.password.text}")) {
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
                            onPressed: () async{
                              if (auth.formKeyRegister.currentState!.validate()) {
                               await auth.register();
                                if (auth.success == true) {
                                  AwesomeDialog(
                                    context: context,
                                    dialogType: DialogType.success,
                                    animType: AnimType.bottomSlide,
                                    title: 'ສຳເລັດ',
                                    desc: 'ລົງທະບຽນສຳເລັດ',
                                    btnCancelOnPress: () {},
                                    btnOkOnPress: () {},
                                  )..show();
                                   Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            BottomBarWidget()),
                                    (route) => false);
                                } else {
                                  AwesomeDialog(
                                    context: context,
                                    dialogType: DialogType.error,
                                    animType: AnimType.rightSlide,
                                    title: 'ຜິດພາດ',
                                    desc: 'ລົງທະບຽນບໍ່ສຳເລັດ',
                                    btnCancelOnPress: () {},
                                    btnOkOnPress: () {},
                                  )..show();
                                }
                              }
                            },
                            child: Center(
                              child: Text(
                                "Register",
                                style: TextStyle(color: Colors.white),
                              ),
                            )),
                      )
                   
                    ],
                  ),
                ),
              ),
            );
          },
        ));
  }
}
