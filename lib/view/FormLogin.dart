import 'package:flutter/material.dart';
import 'package:mobileapp/provider/auth_provider.dart';
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
            return SingleChildScrollView(
              child: Column(children: [
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
                  style: TextStyle(fontSize: 18, color: Colors.indigo.shade800),
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: auth.email,
                  decoration: InputDecoration(
                      hintText: "email",
                      prefix: Icon(
                        Icons.person,
                        color: Colors.indigo.shade800,
                      )),
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
                ),
                SizedBox(height: 20),
                TextButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateColor.resolveWith(
                            (states) => Colors.green)),
                    onPressed: () async {
                      await auth.login();
                      if (auth.success == true) {
                        print("========>Login Sucess");
                      } else {
                        print("========>Faild Login Sucess");
                      }
                    },
                    child: Text(
                      "Login",
                      style: TextStyle(color: Colors.white),
                    ))
              ]),
            );
          },
        ));
  }
}
