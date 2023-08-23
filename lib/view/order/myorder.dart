import 'package:flutter/material.dart';
import 'package:mobileapp/view/components/color.dart';
import 'package:mobileapp/view/order/detail_myOrder.dart';

class MyOrder extends StatelessWidget {
  const MyOrder({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: primaryColorWhite,
          elevation: 0,
          leading: SizedBox(),
          title: Text(
            "ອໍເດີຂອງຂ້ອຍ",
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: primaryColorBlack),
          ),
          centerTitle: true,
        ),
        body: ListView.builder(
            itemCount: 2,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> DetailMyOrder()));
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
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
                            Text(
                              "ຊື່: Iphone 14 Pro Max",
                              style: TextStyle(
                                  fontSize: 15, color: primaryColorBlack),
                            ),
                            Text(
                              "ລາຍລະອຽດ: Iphone 14 Pro Max New gen",
                              style: TextStyle(fontSize: 13, color: Colors.grey),
                            ),
                            Text(
                              "ເວລາ: 05-07-2023",
                              style: TextStyle(fontSize: 13, color: Colors.grey),
                            ),
                             Text(
                              "ສະຖານະ: ກຳລັງຈັດສົ່ງ",
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "ລາຄາ: 20,000,000 ₭",
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
            }));
  }
}
