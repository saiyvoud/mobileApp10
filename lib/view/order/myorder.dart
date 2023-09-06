import 'package:flutter/material.dart';
import 'package:mobileapp/provider/order_provider.dart';
import 'package:mobileapp/view/components/color.dart';
import 'package:mobileapp/view/order/detail_myOrder.dart';
import 'package:provider/provider.dart';

class MyOrder extends StatefulWidget {
  const MyOrder({super.key});

  @override
  State<MyOrder> createState() => _MyOrderState();
}

class _MyOrderState extends State<MyOrder> {
  @override
  void initState() {
    super.initState();
   Provider.of<OrderProvider>(context,listen: false)..getOrderByUser();
  }

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
        body: Consumer<OrderProvider>(
          builder: (context, order, child) {
            if (order.loadingOrder == true) {
              return Center(child: CircularProgressIndicator());
            }
            if (order.order == true) {
              return Center(child: CircularProgressIndicator());
            }
            return ListView.builder(
                shrinkWrap: true,
                itemCount: order.order.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DetailMyOrder(
                                order: order.order[index],
                                books: order.order[index]['books'],
                              )));
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
                              child: Image.network(
                                order.order[index]['bill'],
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
                                  "ຊື່ລູກຄ້າ: Iphone 14 Pro Max",
                                  style: TextStyle(
                                      fontSize: 15, color: primaryColorBlack),
                                ),
                                Text(
                                  "ເບີໂທ: Iphone 14 Pro Max New gen",
                                  style: TextStyle(
                                      fontSize: 13, color: Colors.grey),
                                ),
                                Text(
                                  "ທີ່ຢູ່ຈັດສົ່ງ: 05-07-2023",
                                  style: TextStyle(
                                      fontSize: 13, color: Colors.grey),
                                ),
                                Text(
                                  "ສະຖານະ: ${order.order[index]['status']}",
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "ລາຄາທັງໝົດ: ${order.order[index]['totalPrice']} ₭",
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
                });
          },
        ));
  }
}
