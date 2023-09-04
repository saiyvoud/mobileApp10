import 'package:flutter/material.dart';
import 'package:mobileapp/view/components/color.dart';
import 'package:mobileapp/view/payment/payment.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            "ກະຕ່າ",
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: primaryColorBlack),
          ),
          centerTitle: true,
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 80,
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      "ລາຄາລວມ",
                      style: TextStyle(
                          fontSize: 16,
                          color: primaryColorBlack,
                          fontWeight: FontWeight.bold),
                    ),
                    Spacer(),
                    Text(
                      "1,000,000 ₭",
                      style: TextStyle(
                          fontSize: 18,
                          color: primaryColorRed,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(height: 5),
                InkWell(
                  onTap: (){
                    // Navigator.push(context, MaterialPageRoute(builder: (context)=> PaymentPage(
                    //   bo
                    // )));
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
              ],
            ),
          ),
        ),
        body: ListView.builder(
            itemCount: 2,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 100,
                      width: 100,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(
                          "assets/images/banner1.png",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 200,
                            child: Text(
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              "ຊື່: Iphone 14 Pro Max",
                              style: TextStyle(
                                  fontSize: 15, color: primaryColorBlack),
                            ),
                          ),
                          SizedBox(
                            width: 200,
                            child: Text(
                              "ລາຍລະອຽດ: Iphone 14 Pro Max New gen",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style:
                                  TextStyle(fontSize: 13, color: Colors.grey),
                            ),
                          ),
                          SizedBox(height: 10),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              children: [
                                Container(
                                  height: 20,
                                  width: 50,
                                  decoration: BoxDecoration(
                                      border:
                                          Border.all(color: primaryColorGrey)),
                                  child:
                                      Center(child: Icon(Icons.add, size: 15)),
                                ),
                                SizedBox(width: 10),
                                Text(
                                  "1",
                                  style: TextStyle(color: primaryColorGreen),
                                ),
                                SizedBox(width: 10),
                                Container(
                                    height: 20,
                                    width: 50,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: primaryColorGrey)),
                                    child: Center(
                                      child: Icon(Icons.remove, size: 15),
                                    )),
                              ],
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            "ລາຄາ: 20,000,000 ₭",
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.red,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.delete,
                          color: primaryColorRed,
                        ))
                  ],
                ),
              );
            }));
  }
}
