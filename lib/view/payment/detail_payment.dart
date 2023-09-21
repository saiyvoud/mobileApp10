import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobileapp/model/book_model.dart';
import 'package:mobileapp/provider/order_provider.dart';
import 'package:mobileapp/view/components/bottombar.dart';
import 'package:mobileapp/view/components/color.dart';
import 'package:provider/provider.dart';

class DetailPayment extends StatefulWidget {
  final String time;
  final String address_id;
  final String totalPrice;
  final BookModel bookModel;
  const DetailPayment({
    super.key,
    required this.time,
    required this.address_id,
    required this.bookModel,
    required this.totalPrice,
  });

  @override
  State<DetailPayment> createState() => _DetailPaymentState();
}

class _DetailPaymentState extends State<DetailPayment> {
  File? filename;
  Future<File?> pickGallery({required BuildContext context}) async {
    try {
      var xImage = await ImagePicker().pickImage(
        source: ImageSource.camera,
      );
      if (xImage == null) {}
      var image = File(xImage!.path);
      return image;
    } catch (e) {
      print('Faild to pick image: ${e}');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColorWhite,
      bottomNavigationBar: Consumer<OrderProvider>(
        builder: (context, order, child) {
          return InkWell(
            onTap: () async {
             
              await order.insertOrder(
                image: filename!,
                address_id: widget.address_id,
                books: [{
                  "_id": widget.bookModel.id,
                  "category_id": widget.bookModel.category_id!.id,
                  "name": widget.bookModel.name,
                  "detail": widget.bookModel.detail,
                  "amount": "1",
                  "image": widget.bookModel.image,
                  "order_price": widget.bookModel.order_price.toString(),
                  "sale_price": widget.bookModel.sale_price.toString(),
                }],
                time: widget.time,
                totalPrice: widget.totalPrice,
              );
              if (order.success == true) {
                AwesomeDialog(
                  context: context,
                  dialogType: DialogType.success,
                  animType: AnimType.bottomSlide,
                  title: 'ສຳເລັດ',
                  desc: 'ສ້າງອໍເດີສຳເລັດ',
                  btnCancelOnPress: () {
                     
                  },
                  btnOkOnPress: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BottomBarWidget()),
                        (route) => false);
                  },
                )..show();
              } else {
                AwesomeDialog(
                  context: context,
                  dialogType: DialogType.error,
                  animType: AnimType.bottomSlide,
                  title: 'ຜິດພາດ',
                  desc: 'ສ້າງອໍເດີບໍ່ສຳເລັດ',
                  btnCancelOnPress: () {},
                  btnOkOnPress: () {},
                )..show();
              }
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 50,
                decoration: BoxDecoration(color: primaryColor),
                child: Center(
                  child: order.loadingOrder == true ? CircularProgressIndicator(): Text(
                    "ຢືນຢັນ",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: primaryColorWhite),
                  ),
                ),
              ),
            ),
          );
        },
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
          InkWell(
            onTap: () async {
              final xFile = await pickGallery(context: context);
              var image = File(xFile!.path);
              setState(() {
                filename = image;
              });
            },
            child: Container(
              height: 150,
              width: 150,
              decoration: BoxDecoration(
                  color: primaryColorGrey,
                  borderRadius: BorderRadius.circular(10)),
              child: filename == null
                  ? Icon(
                      Icons.photo,
                      size: 50,
                      color: primaryColorWhite,
                    )
                  : Image.file(
                      filename!,
                      fit: BoxFit.cover,
                    ),
            ),
          ),
        ]),
      ),
    );
  }
}
