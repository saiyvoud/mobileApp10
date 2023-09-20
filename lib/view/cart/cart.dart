import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:mobileapp/provider/cart_provider.dart';
import 'package:mobileapp/view/components/color.dart';
import 'package:mobileapp/view/payment/payment.dart';
import 'package:mobileapp/view/payment/payment_cart.dart';
import 'package:provider/provider.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  void initState() {
    super.initState();
    Provider.of<CartProvider>(context, listen: false)..getCarts();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CartProvider>(builder: (context, cartProvider, child) {
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
          bottomNavigationBar: cartProvider.carts.isEmpty
              ? SizedBox()
              : Padding(
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
                              "${cartProvider.totalPrice.toString()} ₭",
                              style: TextStyle(
                                  fontSize: 18,
                                  color: primaryColorRed,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        SizedBox(height: 5),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => PaymentCart(
                                          books: cartProvider.carts,
                                          totalPrice: cartProvider.totalPrice,
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
                      ],
                    ),
                  ),
                ),
          body: cartProvider.loadingCart == true
              ? Center(child: CircularProgressIndicator())
              : cartProvider.carts.isEmpty
                  ? Center(
                      child: Text("ຍັງບໍ່ມີຂໍ້ມູນ"),
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      itemCount: cartProvider.carts.length,
                      itemBuilder: (context, index) {
                        var data = cartProvider.carts;
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
                                  child: Image.network(
                                    "${cartProvider.carts[index]['image']}",
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
                                        "ຊື່: ${data[index]['name']}",
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: primaryColorBlack),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 200,
                                      child: Text(
                                        "ລາຍລະອຽດ:${data[index]['detail']}",
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontSize: 13, color: Colors.grey),
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: Row(
                                        children: [
                                          GestureDetector(
                                            onTap: () async {
                                              await cartProvider.addAmountCart(
                                                  id: data[index]['id']);

                                              if (cartProvider.sucessCart ==
                                                  true) {
                                                AwesomeDialog(
                                                  context: context,
                                                  dialogType:
                                                      DialogType.success,
                                                  animType:
                                                      AnimType.bottomSlide,
                                                  title: 'ສຳເລັດ',
                                                  desc: 'ເພີ່ມຈຳນວນສິນຄ້າ',
                                                  btnCancelOnPress: () {},
                                                  btnOkOnPress: () {},
                                                )..show();
                                              }
                                            },
                                            child: Container(
                                              height: 20,
                                              width: 50,
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: primaryColorGrey)),
                                              child: Center(
                                                  child: Icon(Icons.add,
                                                      size: 15)),
                                            ),
                                          ),
                                          SizedBox(width: 10),
                                          Text(
                                            "${data[index]['amount']}",
                                            style: TextStyle(
                                                color: primaryColorGreen),
                                          ),
                                          SizedBox(width: 10),
                                          GestureDetector(
                                            onTap: () async {
                                              await cartProvider
                                                  .removeAmountCart(
                                                      id: data[index]['id']);
                                              if (data[index]['amount'] ==
                                                  "1") {
                                                cartProvider.deleteCart(
                                                    id: data[index]['id']);
                                              }
                                              if (cartProvider.sucessCart ==
                                                  true) {
                                                AwesomeDialog(
                                                  context: context,
                                                  dialogType: DialogType.error,
                                                  animType:
                                                      AnimType.bottomSlide,
                                                  title: 'ລົບຈຳນວນ',
                                                  desc: 'ລົບຈຳນວນສິນຄ້າສຳເລັດ',
                                                  btnCancelOnPress: () {},
                                                  btnOkOnPress: () {},
                                                )..show();
                                              }
                                            },
                                            child: Container(
                                                height: 20,
                                                width: 50,
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color:
                                                            primaryColorGrey)),
                                                child: Center(
                                                  child: Icon(Icons.remove,
                                                      size: 15),
                                                )),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      "ລາຄາ: ${data[index]['sale_price']} ₭",
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.red,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                              IconButton(
                                  onPressed: () async {
                                    cartProvider.deleteCart(
                                        id: data[index]['id']);
                                    if (cartProvider.sucessCart == true) {
                                      // AwesomeDialog(
                                      //   context: context,
                                      //   dialogType: DialogType.error,
                                      //   animType: AnimType.bottomSlide,
                                      //   title: 'ລົບຈຳນວນ',
                                      //   desc: 'ລົບຈຳນວນສິນຄ້າສຳເລັດ',
                                      //   btnCancelOnPress: () {},
                                      //   btnOkOnPress: () {},
                                      // )..show();
                                    }
                                  },
                                  icon: Icon(
                                    Icons.delete,
                                    color: primaryColorRed,
                                  ))
                            ],
                          ),
                        );
                      }));
    });
  }
}
