import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:mobileapp/provider/auth_provider.dart';
import 'package:mobileapp/view/auth/FormLogin.dart';
import 'package:mobileapp/view/components/bottombar.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {


  @override
  Widget build(BuildContext context) {
    Provider.of<AuthProvider>(context)..validateAuth();
    return Scaffold(
       
        body: Consumer<AuthProvider>(
          builder: (context, auth, child) {
            if (auth.success == true) {
              return BottomBarWidget();
            } else if (auth.success == false) {
              return FormLogin();
            }
            return SingleChildScrollView(
              child: Center(
                child: Column(
                  children: [
                    SizedBox(height: 100),
                    ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(
                          "assets/images/logo.png",
                          height: 120,
                        )),
                    SizedBox(height: 10),
                    Text("Buy Easy Sell Easy"),
                    Align(
                        alignment: Alignment.bottomCenter,
                        child: Lottie.asset('assets/animations/loading.json',
                            height: 120)),
                  ],
                ),
              ),
            );
          },
        ));
  }
}
