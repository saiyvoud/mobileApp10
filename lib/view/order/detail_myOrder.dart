import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mobileapp/view/components/color.dart';

class DetailMyOrder extends StatefulWidget {
  const DetailMyOrder({super.key});

  @override
  State<DetailMyOrder> createState() => _DetailMyOrderState();
}

class _DetailMyOrderState extends State<DetailMyOrder> {
  @override
  Widget build(BuildContext context) {
     return Scaffold(
      backgroundColor: Colors.grey.shade200,
      bottomNavigationBar: InkWell(
        onTap: () {
          AwesomeDialog(
            context: context,
            dialogType: DialogType.success,
            animType: AnimType.bottomSlide,
            title: 'ແຈ້ງເຕືອນ',
            desc: 'ສຳເລັດການຢືນຢັນ',
            btnCancelOnPress: () {},
            btnOkOnPress: () {},
          )..show();
        },
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            height: 60,
            decoration: BoxDecoration(color: primaryColorGreen),
            child: Center(
              child: Text(
                "ຢືນຢັນການສຳເລັດ",
                style: TextStyle(
                    color: primaryColorWhite,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ),
     
      appBar: AppBar(
        elevation: 0,
        backgroundColor: primaryColorWhite,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: primaryColorBlack,
            )),
        title: Text(
          "Order Detail",
          style:
              TextStyle(color: primaryColorBlack, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              height: MediaQuery.of(context).size.height / 1.2,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: primaryColorWhite,
                  borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10),
                    Center(
                        child: SvgPicture.asset(
                      "assets/icons/warning.svg",
                      color: primaryColor,
                      height: 50,
                    )),
                    SizedBox(height: 10),
                    Divider(
                      indent: 50,
                      endIndent: 50,
                      height: 30,
                    ),
                    Text(
                      "ລາຍລະອຽດສິນຄ້າ",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Text("ຊື່ສິນຄ້າ"),
                        Spacer(),
                        Text("Iphone Pro Max 14"),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Text("ຮູບພາບ"),
                        Spacer(),
                        Image.asset(
                          "assets/images/banner1.png",
                          height: 30,
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Text("ລາຄາ"),
                        Spacer(),
                        Text(
                          "20,000,000 ₭",
                          style: TextStyle(color: Colors.red),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Divider(
                      indent: 50,
                      endIndent: 50,
                      height: 30,
                    ),
                    Text(
                      "ລາຍລະອຽດການຈັດສົ່ງ",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Text("ບ້ານ"),
                        Spacer(),
                        Text("dong dok"),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Text("ເມືອງ"),
                        Spacer(),
                        Text("xaythany"),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Text("ແຂວງ"),
                        Spacer(),
                        Text("ນະຄອນຫຼວງວຽງຈັນ"),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Text("ເວລາຈັດສົ່ງ"),
                        Spacer(),
                        Text("05-07-2023"),
                      ],
                    ),
                    SizedBox(height: 10),
                    Divider(
                      indent: 50,
                      endIndent: 50,
                      height: 30,
                    ),
                    Text(
                      "ລາຍລະອຽດລູກຄ້າ",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Text("ຊື່ ແລະ ນາມສະກຸນ"),
                        Spacer(),
                        Text("MiDi Technology"),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Text("ເບີໂທຕິດຕໍ່"),
                        Spacer(),
                        Text("020 96794376"),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  
  }
}