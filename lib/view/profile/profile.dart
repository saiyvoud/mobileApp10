import 'package:flutter/material.dart';
import 'package:mobileapp/view/components/color.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(color: primaryColor),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    SizedBox(height: 80),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 80,
                          width: 80,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(60),
                              color: primaryColorGrey),
                          child: Center(
                            child: Icon(
                              Icons.person,
                              color: primaryColorWhite,
                              size: 35,
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 10),
                              Text(
                                "Saiyvoud Somnaong",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColorWhite),
                              ),
                              SizedBox(height: 5),
                              Text(
                                "+8562054998433",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColorWhite),
                              ),
                            ])
                      ],
                    ),
                  ],
                ),
              ),
            ),
            ListView.builder(
                shrinkWrap: true,
                primary: false,
                itemCount: 6,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 50,decoration: BoxDecoration(border: Border.all(color: primaryColorGrey),borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          children: [
                            Icon(Icons.edit),
                            SizedBox(width: 10),
                            Text(
                              "ແກ້ໄຂຂໍ້ມູນ",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 18,
                          
                                  color: primaryColorBlack),
                            ),
                            Spacer(),
                            Icon(Icons.arrow_forward_ios,color: primaryColorBlack,)
                          ],
                        ),
                      ),
                    ),
                  );
                })
          ],
        ),
      ),
    );
  }
}
