import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobileapp/model/book_model.dart';
import 'package:mobileapp/provider/address_provider.dart';
import 'package:mobileapp/provider/order_provider.dart';
import 'package:mobileapp/view/components/color.dart';
import 'package:mobileapp/view/payment/address.dart';
import 'package:mobileapp/view/payment/detail_payment.dart';
import 'package:mobileapp/view/payment/update_address.dart';
import 'package:provider/provider.dart';

class PaymentPage extends StatefulWidget {
  final BookModel bookModel;
  const PaymentPage({super.key, required this.bookModel});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  BitmapDescriptor? icon;
  DateTime? dateTime;
  File? filename;

  @override
  void initState() {
    super.initState();
    Provider.of<AddressProvider>(context, listen: false)..getByUser();
    BitmapDescriptor.fromAssetImage(
            ImageConfiguration(size: Size(48, 48)), "assets/icons/pin.png")
        .then((value) {
      setState(() {
        icon = value;
      });
    });
  }

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

  showPayment(
    BuildContext context,
    String address_id,
  ) {
    showDialog(
        context: context,
        builder: (context) {
          return Consumer<OrderProvider>(builder: (context, order, child) {
            return AlertDialog(
              title: Text(
                "ໂປຣຊຳລະເງີນ",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: primaryColorBlack,
                ),
              ),
              content: Column(
                children: [
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
                ],
              ),
              actions: [
                InkWell(
                  onTap: () async {
                    Navigator.pop(context);
                    await order.insertOrder(
                      image: filename!,
                      address_id: address_id,
                      books: {
                        "category_id": widget.bookModel.category_id.toString(),
                        "name": widget.bookModel.name,
                        "detail": widget.bookModel.detail,
                        "amount": 1,
                        "image": widget.bookModel.image,
                        "order_price": widget.bookModel.order_price.toString(),
                        "sale_price": widget.bookModel.sale_price.toString(),
                      },
                      time: dateTime.toString(),
                      totalPrice: widget.bookModel.sale_price.toString(),
                    );
                    if (order.success == true) {
                      AwesomeDialog(
                        context: context,
                        dialogType: DialogType.success,
                        animType: AnimType.bottomSlide,
                        title: 'ສຳເລັດ',
                        desc: 'ສ້າງອໍເດີສຳເລັດ',
                        btnCancelOnPress: () {},
                        btnOkOnPress: () {},
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
                ),
              ],
            );
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AddressProvider>(builder: (context, address, child) {
      if (address.loadingAddress == true) {
        return Scaffold(
          body: Center(child: CircularProgressIndicator()),
        );
      }
     
      return Scaffold(
        backgroundColor: primaryColorWhite,
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
            "Payment",
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: primaryColorBlack),
          ),
          centerTitle: true,
        ),
        bottomNavigationBar: address.success == false? SizedBox() :  Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () {
              // showPayment(context, address.addressModel.id.toString());
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DetailPayment(
                            address_id: address.addressModel.id.toString(),
                            bookModel: widget.bookModel,
                            time: dateTime.toString(),
                            totalPrice: widget.bookModel.sale_price.toString(),
                          )));
            },
            child: Container(
              height: 50,
              decoration: BoxDecoration(color: primaryColor),
              child: Center(
                child: Text(
                  "ຊຳລະເງີນ",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: primaryColorWhite),
                ),
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                SizedBox(height: 10),
              address.success == false ? SizedBox():  Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('ຊື່ ແລະ ນາມສະກຸນ',
                              style: TextStyle(fontSize: 12, color: Colors.black)),
                          Text('${address.addressModel.customer}',
                              style: TextStyle(fontSize: 12, color: Colors.black)),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('ເບີໂທຕິດຕໍ່',
                              style: TextStyle(fontSize: 12, color: Colors.black)),
                          Text('+856 ${address.addressModel.phone} ',
                              style: TextStyle(fontSize: 12, color: Colors.black)),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Container(
                  height: 10,
                  decoration: BoxDecoration(color: Colors.grey.shade100),
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Icon(Icons.time_to_leave, color: primaryColorBlack),
                    SizedBox(width: 5),
                    Text('ເວລາຈັດສົ່ງສິນຄ້າ',
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.black)),
                    Spacer(),
                    InkWell(
                        onTap: () async {
                          final date = await address.pickDateTime(context);
                          if (date == null) return;

                          setState(() => dateTime = date);
                        },
                        child: Icon(Icons.edit, color: Colors.green)),
                  ],
                ),
                SizedBox(height: 10),
                Container(
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(color: primaryColor),
                  child: Center(
                      child: dateTime == null
                          ? Text(
                              "00-00-00",
                              style: TextStyle(
                                  color: primaryColorWhite,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            )
                          : Text(
                              "ວັນ/ເດືອນ/ປີ: ${dateTime!.day}-${dateTime!.month}-${dateTime!.year} ",
                              style: TextStyle(
                                  color: primaryColorWhite,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            )),
                ),
                SizedBox(height: 10),
                Container(
                  height: 10,
                  decoration: BoxDecoration(color: Colors.grey.shade100),
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Icon(Icons.map, color: primaryColorBlack),
                    SizedBox(width: 5),
                    Text('ສະຖານທີ່ຈັດສົ່ງສິນຄ້າ',
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.black)),
                    Spacer(),
                   address.success ==false ? SizedBox(): IconButton(
                      onPressed: () {
                        // Navigator.pushNamed(context, RouterAPI.address);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => UpdateAddress()));
                      },
                      icon: Icon(Icons.edit, color: Colors.green),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                address.success == false
                    ? 
                    InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AddressPage()));
                        },
                        child: Container(
                          height: 50,
                          width: double.infinity,
                          decoration: BoxDecoration(color: primaryColor),
                          child: Center(
                            child: Text(
                              "+ ເພີມທີ່ຢູ່ຈັດສົ່ງ",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColorWhite),
                            ),
                          ),
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('ບ້ານ ເມືອງ ແຂວງ',
                                style: TextStyle(
                                    fontSize: 12, color: Colors.black)),
                            Text(
                                '${address.addressModel.village} ${address.addressModel.district} ${address.addressModel.province} ',
                                style: TextStyle(
                                    fontSize: 12, color: Colors.black)),
                          ],
                        ),
                      ),
                SizedBox(height: 10),
               address.success == false ? SizedBox():  Container(
                  height: 120,
                  decoration: BoxDecoration(color: primaryColor),
                  child: address.success == false
                      ? Center(
                          child: SizedBox(),
                        )
                      : GoogleMap(
                          initialCameraPosition: CameraPosition(
                            target: LatLng(
                              double.parse(
                                address.addressModel.latitude!,
                              ),
                              double.parse(
                                address.addressModel.longitude!,
                              ),
                            ),
                            zoom: 14,
                          ),
                          markers: <Marker>[
                            Marker(
                              markerId: MarkerId('MarkerId'),
                              position: LatLng(
                                double.parse(
                                  address.addressModel.latitude!,
                                ),
                                double.parse(
                                  address.addressModel.longitude!,
                                ),
                              ),
                              icon: icon!,
                              infoWindow: InfoWindow(
                                  title: 'This is a Title',
                                  snippet: 'this is a snippet'),
                            ),
                          ].toSet(),
                        ),
                ),

                ///-----

                SizedBox(height: 10),
                Container(
                  height: 10,
                  decoration: BoxDecoration(color: Colors.grey.shade100),
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Icon(Icons.list_alt, color: primaryColorBlack),
                    SizedBox(width: 5),
                    Text('ລາຍລະອຽດສິນຄ້າ',
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.black)),
                    // Spacer(),
                    // Icon(Icons.edit, color: Colors.green),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('ຮູບສິນຄ້າ',
                          style: TextStyle(fontSize: 12, color: Colors.black)),
                      Text('ຊື່',
                          style: TextStyle(fontSize: 12, color: Colors.black)),
                      Text('ລາຄາ',
                          style: TextStyle(fontSize: 12, color: Colors.black)),
                    ],
                  ),
                ),

                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.network(
                        widget.bookModel.image!,
                        height: 20,
                        fit: BoxFit.cover,
                      ),
                      Text('${widget.bookModel.name}',
                          style: TextStyle(fontSize: 12, color: Colors.black)),
                      Text('${widget.bookModel.sale_price} LAK',
                          style: TextStyle(fontSize: 12, color: Colors.black)),
                    ],
                  ),
                ),

                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('ລາຄາລວມ',
                          style: TextStyle(fontSize: 12, color: Colors.black)),
                      Text('${widget.bookModel.sale_price} Kip',
                          style: TextStyle(fontSize: 15, color: Colors.red)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
