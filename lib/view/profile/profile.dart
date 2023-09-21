import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mobileapp/provider/auth_provider.dart';
import 'package:mobileapp/view/auth/FormLogin.dart';
import 'package:mobileapp/view/components/color.dart';
import 'package:mobileapp/view/components/data.dart';
import 'package:mobileapp/view/profile/edit_password.dart';
import 'package:mobileapp/view/profile/edit_profile.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  void initState() {
    super.initState();
    Provider.of<AuthProvider>(context, listen: false)..getProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Consumer<AuthProvider>(
      builder: (context, auth, child) {
        if (auth.loading == true) {
          return Center(child: CircularProgressIndicator());
        }
        return SingleChildScrollView(
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
                            child: auth.userModel.profile == ""
                                ? Center(
                                    child: Icon(
                                      Icons.person,
                                      color: primaryColorWhite,
                                      size: 35,
                                    ),
                                  )
                                : ClipRRect(
                                  borderRadius: BorderRadius.circular(60),
                                  child: Image.network(
                                      auth.userModel.profile.toString(),fit: BoxFit.cover,),
                                ),
                          ),
                          SizedBox(width: 10),
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 10),
                                Text(
                                  auth.userModel.username.toString(),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColorWhite),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  "+85620${auth.userModel.phone}",
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
                  itemCount: profiles.length,
                  itemBuilder: (context, index) {
                    final data = profiles[index];
                    return InkWell(
                      onTap: () {
                        if (index == 0) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => EditProfile(
                                      image: auth.userModel.profile.toString())));
                        } else if (index == 1) {
                           Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => EditPassword(
                                      image: auth.userModel.profile.toString())));
                        } else if (index == 2) {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => FormLogin()),
                              (route) => false);
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                              border: Border.all(color: primaryColorGrey),
                              borderRadius: BorderRadius.circular(10)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              children: [
                                SvgPicture.asset(
                                  data['icon'].toString(),
                                  fit: BoxFit.cover,
                                  height: 25,
                                ),
                                SizedBox(width: 10),
                                Text(
                                  data['title'].toString(),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 18, color: primaryColorBlack),
                                ),
                                Spacer(),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  color: primaryColorBlack,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  })
            ],
          ),
        );
      },
    ));
  }
}
