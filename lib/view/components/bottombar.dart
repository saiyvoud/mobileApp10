// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mobileapp/view/components/color.dart';
import 'package:mobileapp/view/home/home.dart';

class BottomBarWidget extends StatefulWidget {
  const BottomBarWidget({super.key});

  @override
  State<BottomBarWidget> createState() => _BottomBarWidgetState();
}

class _BottomBarWidgetState extends State<BottomBarWidget> {
  int currentIndex = 0;
  var _children = [
    HomePage(),
    Container(height: 200, decoration: BoxDecoration(color: Colors.green)),
    Container(height: 200, decoration: BoxDecoration(color: Colors.indigo)),
  ];
  void _onTap(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentIndex,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: primaryColor,
          onTap: _onTap,
          items: [
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                "assets/icons/home.svg",
                height: 20,
                color: Colors.grey,
              ),
              label: "ຫນ້າຫຼັກ",
              activeIcon: SvgPicture.asset(
                "assets/icons/home.svg",
                height: 20,
                color: primaryColor,
              ),
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                "assets/icons/order.svg",
                height: 20,
                color: Colors.grey,
              ),
              label: "ອໍເດີຂອງຂ້ອຍ",
              activeIcon: SvgPicture.asset(
                "assets/icons/order.svg",
                height: 20,
                color: primaryColor,
              ),
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                "assets/icons/profile.svg",
                height: 20,
                color: Colors.grey,
              ),
              label: "ໂປຣໄຟ",
              activeIcon: SvgPicture.asset(
                "assets/icons/profile.svg",
                height: 20,
                color: primaryColor,
              ),
            ),
          ]),
    );
  }
}
