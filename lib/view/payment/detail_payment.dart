import 'package:flutter/material.dart';
import 'package:mobileapp/view/components/color.dart';

class DetailPayment extends StatelessWidget {
  const DetailPayment({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColorWhite,
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 50,
          decoration: BoxDecoration(color: primaryColor),
          child: Center(
            child: Text(
              "ຢືນຢັນ",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: primaryColorWhite),
            ),
          ),
        ),
      ),
      appBar: AppBar(
        backgroundColor: primaryColorWhite,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: primaryColorBlack,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          "ລາຍລະອຽດການຊຳລະ",
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: primaryColorBlack),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          Center(
            child: Image.asset(
              "assets/images/onepay.png",
              fit: BoxFit.cover,
              //height: 300,
            ),
          ),
          Text(
            "Qr code ຈ່າຍເງີນ",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Container(
            height: 200,
            width: 200,
            decoration: BoxDecoration(
                color: primaryColorGrey,
                borderRadius: BorderRadius.circular(10)),
            child: Icon(
              Icons.photo,
              size: 50,
              color: primaryColorWhite,
            ),
          ),
        ]),
      ),
    );
  }
}
