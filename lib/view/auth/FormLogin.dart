import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:mobileapp/provider/auth_provider.dart';
import 'package:mobileapp/view/auth/Formregister.dart';
import 'package:mobileapp/view/components/bottombar.dart';
import 'package:provider/provider.dart';

class FormLogin extends StatefulWidget {
  const FormLogin({super.key});

  @override
  State<FormLogin> createState() => _FormLoginState();
}

class _FormLoginState extends State<FormLogin> {
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
        body: Consumer<AuthProvider>(
          builder: (context, auth, child) {
            if (auth.loading == true) {
              return Center(child: CircularProgressIndicator());
            }
            return Form(
              key: auth.formKey,
              child: SingleChildScrollView(
                child: Column(children: [
                  SizedBox(height: 30),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      "assets/images/logo.png",
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: 30),
                  Text(
                    "Welcome!",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.indigo.shade800),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Signin Continue!",
                    style:
                        TextStyle(fontSize: 18, color: Colors.indigo.shade800),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: auth.email,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        hintText: "email",
                        prefix: Icon(
                          Icons.person,
                          color: Colors.indigo.shade800,
                        )),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "email is required";
                      } else if (!value.contains("@gmail.com")) {
                        return "@gmail.com is required!";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: auth.password,
                    obscureText: true,
                    decoration: InputDecoration(
                        hintText: "password",
                        prefix: Icon(
                          Icons.person,
                          color: Colors.indigo.shade800,
                        )),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "password is required!";
                      } else if (value.length < 6) {
                        return "password must 6 than more";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateColor.resolveWith(
                                  (states) => Colors.green)),
                          onPressed: () async {
                            if (auth.formKey.currentState!.validate()) {
                              auth.login();
                              if (auth.success == true) {
                                AwesomeDialog(
                                  context: context,
                                  dialogType: DialogType.success,
                                  animType: AnimType.bottomSlide,
                                  title: 'ສຳເລັດ',
                                  desc: 'ເຂົ້າສູ່ລະບົບສຳເລັດ',
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
                                  desc: 'ເຂົ້າສູ່ລະບົບບໍ່ສຳເລັດ',
                                  btnCancelOnPress: () {},
                                  btnOkOnPress: () {},
                                )..show();
                              }
                            }
                          },
                          child: Text(
                            "Login",
                            style: TextStyle(color: Colors.white),
                          )),
                      SizedBox(width: 20),
                      TextButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateColor.resolveWith(
                                  (states) => Colors.amber)),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => FormRegister()));
                          },
                          child: Text(
                            "Register",
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ))
                    ],
                  ),
                ]),
              ),
            );
          },
        ));
  }
}
