import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:mobileapp/view/components/Table.dart';
import 'package:mobileapp/view/components/data.dart';

class BannerWidget extends StatefulWidget {
  const BannerWidget({super.key});

  @override
  State<BannerWidget> createState() => _BannerWidgetState();
}

class _BannerWidgetState extends State<BannerWidget> {
  int currentIndex = 0;
  void _onPage(index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade800,
        leading: Icon(Icons.menu),
        //centerTitle: true,
        title: Row(
          children: [
            Image.network(
              'https://www.searchenginejournal.com/wp-content/uploads/2022/06/image-search-1600-x-840-px-62c6dc4ff1eee-sej.png',
              height: 30,
            ),
            SizedBox(width: 10),
            Text(
              "Welcome to Course",
              style: TextStyle(fontSize: 15),
            )
          ],
        ),
        actions: [
          Icon(Icons.notifications),
          SizedBox(width: 20),
          Icon(Icons.shopping_cart),
          SizedBox(width: 20),
        ],
      ),
      body: Column(
        children: [
          SizedBox(height: 10),
          CarouselSlider.builder(
            itemCount: bannerList.length,
            itemBuilder: (context, index, realIndex) {
              return Container(
                margin: EdgeInsets.symmetric(horizontal: 5),
                child: Image.asset(bannerList[index], fit: BoxFit.cover),
              );
            },
            options: CarouselOptions(
              autoPlay: true,
              height: 120,
              onPageChanged: (index, reason) {
                _onPage(index);
              },
            ),
          ),
          SizedBox(height: 5),
          Container(
            height: 10,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                primary: false,
                shrinkWrap: true,
                itemCount: bannerList.length,
                itemBuilder: (context, index) {
                  return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 5),
                          height: currentIndex == index ? 8 : 2,
                          width: 10,
                          decoration: BoxDecoration(
                              color: currentIndex == index
                                  ? Colors.red
                                  : Colors.black,
                              shape: currentIndex == index
                                  ? BoxShape.circle
                                  : BoxShape.rectangle),
                        ),
                      ]);
                }),
          ),
          SizedBox(height: 10),
          TableWidget(),
        ],
      ),
    );
  }
}
