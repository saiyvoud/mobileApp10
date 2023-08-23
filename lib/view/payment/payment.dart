import 'package:flutter/material.dart';
import 'package:mobileapp/view/components/color.dart';
import 'package:mobileapp/view/payment/detail_payment.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  @override
  Widget build(BuildContext context) {
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
      
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => DetailPayment()));
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('ຊື່ ແລະ ນາມສະກຸນ',
                        style: TextStyle(fontSize: 12, color: Colors.black)),
                    Text(
                        //'${authProvider.userModel.firstName} ${authProvider.userModel.lastName}',
                        '',
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
                    Text('+856 ',
                        style: TextStyle(fontSize: 12, color: Colors.black)),
                  ],
                ),
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
                        // final date = await pickDateTime(context);
                        // if (date == null) return;

                        // setState(() => dateTime = date);
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
                      // child: dateTime == null
                      //     ? Text(
                      //         "00-00-00",
                      //         style: TextStyle(
                      //             color: primaryColorWhite,
                      //             fontSize: 18,
                      //             fontWeight: FontWeight.bold),
                      //       )
                      //     : Text(
                      //         "ວັນ/ເດືອນ/ປີ: ${dateTime!.day}-${dateTime!.month}-${dateTime!.year} ",
                      //         style: TextStyle(
                      //             color: primaryColorBlack,
                      //             fontSize: 18,
                      //             fontWeight: FontWeight.bold),
                      //       )),
                      )),
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
                  IconButton(
                    onPressed: () {
                      // Navigator.pushNamed(context, RouterAPI.address);
                    },
                    icon: Icon(Icons.edit, color: Colors.green),
                  ),
                ],
              ),
              SizedBox(height: 10),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('ບ້ານ ເມືອງ ແຂວງ',
                        style: TextStyle(fontSize: 12, color: Colors.black)),
                    Text(
                        // '${addressProvider.address.village} ${addressProvider.address.district} ${addressProvider.address.province} ',
                        "",
                        style: TextStyle(fontSize: 12, color: Colors.black)),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Container(
                height: 120,
                decoration: BoxDecoration(color: primaryColor),
                // child: GoogleMap(
                //   initialCameraPosition: CameraPosition(
                //     target: LatLng(
                //       double.parse(
                //         addressProvider.address.latitude!,
                //       ),
                //       double.parse(
                //         addressProvider.address.longtitude!,
                //       ),
                //     ),
                //     zoom: 14,
                //   ),
                //   markers: <Marker>[
                //     Marker(
                //       markerId: MarkerId('MarkerId'),
                //       position: LatLng(
                //         double.parse(
                //           addressProvider.address.latitude!,
                //         ),
                //         double.parse(
                //           addressProvider.address.longtitude!,
                //         ),
                //       ),
                //       icon: icon!,
                //       infoWindow: InfoWindow(
                //           title: 'This is a Title',
                //           snippet: 'this is a snippet'),
                //     ),
                //   ].toSet(),
                // ),
              ),
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
                  Spacer(),
                  Icon(Icons.edit, color: Colors.green),
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
                    // Image.network(
                    //   widget.productModel.image!,
                    //   height: 20,
                    //   fit: BoxFit.cover,
                    // ),
                    Text('name}',
                        style: TextStyle(fontSize: 12, color: Colors.black)),
                    Text('100000 LAK',
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
                    Text(' Kip',
                        style: TextStyle(fontSize: 15, color: Colors.red)),
                  ],
                ),
              ),

              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 5),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: [
              //       Text('ປະເພດທີ່ຢູ່ອາໄສ',
              //           style: TextStyle(
              //               fontSize: 12, color: Colors.black)),
              //       Text('ບ້ານ',
              //           style: TextStyle(
              //               fontSize: 12, color: Colors.black)),
              //     ],
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
