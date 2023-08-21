import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:mobileapp/view/home/home_detail.dart';
import 'package:provider/provider.dart';

import '../../provider/book_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    Provider.of<BookProvider>(context, listen: false)..fecthBook();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 248, 248, 248),
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 248, 248, 248),
          elevation: 0,
          leading: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: Colors.white,
            ),
            child: Icon(
              Icons.widgets,
              color: Color.fromARGB(255, 252, 123, 125),
              size: 23,
            ),
          ),
          actions: [
            Row(
              children: [
                Stack(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Colors.white,
                      ),
                      child: Icon(
                        Icons.shopping_bag,
                        color: Color.fromARGB(255, 204, 193, 193),
                        size: 25,
                      ),
                    ),
                    Positioned(
                      top: 10,
                      left: 22,
                      child: Icon(
                        Icons.circle,
                        color: Color.fromARGB(255, 252, 123, 125),
                        size: 6,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  width: 10,
                ),
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: Colors.white,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Image.network(
                      'https://img.freepik.com/free-photo/happiness-carefree-asian-female-woman-teen-wearing-headphone-listen-dance-joyful-fun-moving-moment-teen-wear-casaul-cloth-singing-move-while-laugh-smile-trendy-lifestyle-studio-shot_609648-2947.jpg?w=1380&t=st=1692003906~exp=1692004506~hmac=bd579a758ed4714e6e6e727c0ae99e8f27758ad8f881f16a98306e0e1a8e3fa4',
                      width: 40,
                      height: 40,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
        body: Consumer<BookProvider>(
          builder: (context, books, child) {
            if (books.loadingBook == true) {
              return Center(child: CircularProgressIndicator());
            }
            return GridView.builder(
                shrinkWrap: true,
                primary: false,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    //mainAxisExtent: 0.5,
                    childAspectRatio: 0.7,
                    mainAxisSpacing: 1.2),
                itemCount: books.books!.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    HomeDetail(bookModel: books.books![index])));
                      },
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                        height: 240,
                        width: 168,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.03),
                              blurRadius: 16,
                              offset: Offset(1, 1), // Shadow position
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Container(
                                child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 3, horizontal: 5),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: Color.fromARGB(255, 178, 229, 231),
                                  ),
                                  child: Text(
                                    "20% OFF",
                                    style: TextStyle(
                                      fontSize: 7,
                                      fontWeight: FontWeight.w800,
                                      color: Color.fromARGB(255, 79, 79, 79),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  width: 25,
                                  height: 25,
                                  //color: Colors.grey[600],
                                  child: Icon(
                                    Icons.favorite,
                                    size: 22,
                                    color: Color.fromARGB(255, 239, 29, 29),
                                  ),
                                )
                              ],
                            )),
                            Container(
                              height: 100,
                              color: Colors.grey[600],
                              child: Stack(
                                children: [
                                  Image.network(
                                    "https://wallpapercave.com/wp/wp5943533.jpg",
                                    fit: BoxFit.contain,
                                  ),
                                  Positioned(
                                    child: Image.network(
                                      // "https://shop.kicker.de/de-de/Data/Images/Big/orange-puma-evopower-vigor-4-it-halle-kids-f03.png",
                                      books.books![index].image!,
                                      fit: BoxFit.contain,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Shoes",
                                style: TextStyle(
                                    color: Colors.grey[700],
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                });
          },
        ));
  }
}
