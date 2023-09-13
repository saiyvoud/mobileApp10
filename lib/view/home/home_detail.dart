import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:mobileapp/model/book_model.dart';
import 'package:mobileapp/provider/cart_provider.dart';
import 'package:mobileapp/view/components/color.dart';
import 'package:mobileapp/view/payment/payment.dart';
import 'package:provider/provider.dart';

class HomeDetail extends StatefulWidget {
  final BookModel bookModel;
  const HomeDetail({super.key, required this.bookModel});

  @override
  State<HomeDetail> createState() => _HomeDetailState();
}

class _HomeDetailState extends State<HomeDetail> {
  int amount = 1;

  void addAmount() {
    setState(() {
      amount++;
    });
  }

  void removeAmount() {
    if (amount == 1) {
    } else {
      setState(() {
        amount--;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<CartProvider>(context, listen: false)..getCarts();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CartProvider>(builder: (context, cartProvider, child) {
      return Scaffold(
        bottomNavigationBar: Container(
          height: 60,
          // decoration: BoxDecoration(color: primaryColorRed),
          child: Row(children: [
            SizedBox(width: 10),
            Container(
              height: 50,
              width: 150,
              child: TextButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateColor.resolveWith(
                          (states) => Colors.green)),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PaymentPage(
                                  bookModel: widget.bookModel,
                                )));
                  },
                  child: Center(
                    child: Text(
                      "ຊື້ເລີຍ",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                  )),
            ),
            Spacer(),
            Container(
              height: 50,
              width: 150,
              child: TextButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateColor.resolveWith(
                          (states) => Colors.amber)),
                  onPressed: () async {
                    await cartProvider.addCart(
                        books: widget.bookModel, amount: amount);
                    if (cartProvider.sucessCart == true) {
                      AwesomeDialog(
                        context: context,
                        dialogType: DialogType.success,
                        animType: AnimType.bottomSlide,
                        title: 'ສຳເລັດ',
                        desc: 'ເພີ່ມສິນຄ້າໄປທີ່ກະຕ່າແລ້ວ',
                        btnCancelOnPress: () {},
                        btnOkOnPress: () {},
                      )..show();
                      cartProvider.getCarts();
                    } else {
                      AwesomeDialog(
                        context: context,
                        dialogType: DialogType.error,
                        animType: AnimType.bottomSlide,
                        title: 'ຜິດພາດ',
                        desc: 'ເພີ່ມສິນຄ້າໄປທີ່ກະຕ່າແລ້ວບໍ່ໄດ້',
                        btnCancelOnPress: () {},
                        btnOkOnPress: () {},
                      )..show();
                    }
                  },
                  child: Center(
                    child: Text(
                      "ເພີ່ມເຂົ້າກະຕ້າ",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                  )),
            ),
            SizedBox(width: 10),
          ]),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 340,
                decoration: BoxDecoration(boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 10,
                    offset: Offset(1, 1), // Shadow position
                  ),
                ], borderRadius: BorderRadius.circular(10)),
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                  child: Stack(
                    children: [
                      Image.network(
                        widget.bookModel.image!,
                        // height: 340,
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                      Positioned(
                          top: 40,
                          left: 10,
                          child: Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10)),
                            child: IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: Icon(
                                  Icons.arrow_back_ios,
                                  color: primaryColorBlack,
                                )),
                          )),
                      Positioned(
                          top: 40,
                          right: 10,
                          child: Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10)),
                            child: Stack(
                              children: [
                                IconButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    icon: Icon(
                                      Icons.shopping_cart,
                                      color: primaryColorBlack,
                                    )),
                                Positioned(
                                    top: 2,
                                    right: 3,
                                    child: Container(
                                      height: 20,
                                      width: 20,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          color: primaryColorRed),
                                      child: Center(
                                        child: Text(
                                          "${cartProvider.carts.length}",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ))
                              ],
                            ),
                          )),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "ລາຍລະອຽດສິນຄ້າ",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: primaryColorBlack,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "${widget.bookModel.name}",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: primaryColorBlack),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "${widget.bookModel.detail}",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: primaryColorGrey),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "${widget.bookModel.sale_price} LAK/${widget.bookModel.qty} ຈຳນວນ",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: primaryColorRed),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "ລາຍລະອຽດຈັດສົ່ງ",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: primaryColorBlack),
                      ),
                      Text(
                        "ການຈັດສົ່ງພາຍໃນ1-2 ມື້",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: primaryColorGrey),
                      ),
                      SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () {
                                addAmount();
                              },
                              child: Container(
                                height: 40,
                                width: 100,
                                decoration: BoxDecoration(
                                    border:
                                        Border.all(color: primaryColorGrey)),
                                child: Center(child: Icon(Icons.add, size: 25)),
                              ),
                            ),
                            Text(amount.toString()),
                            InkWell(
                              onTap: () {
                                removeAmount();
                              },
                              child: Container(
                                height: 40,
                                width: 100,
                                decoration: BoxDecoration(
                                    border:
                                        Border.all(color: primaryColorGrey)),
                                child:
                                    Center(child: Icon(Icons.remove, size: 25)),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
