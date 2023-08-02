import 'package:flutter/material.dart';

class StackWidget extends StatelessWidget {
  const StackWidget({super.key});

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
      body: Container(
        height: 300,
        // decoration: BoxDecoration(color: Colors.red),
        child: Stack(children: [
          Container(
            height: 150,
            width: double.infinity,
            child: Image.asset(
              "assets/images/phone.png",
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: 80,
            left: 10,
            right: 10,
            // top: 100,
            // top: 10,
            // bottom: 10,
            child: Container(
              height: 100,
              width: MediaQuery.of(context).size.width / 1,
              decoration: BoxDecoration(
                  color: Colors.red, borderRadius: BorderRadius.circular(10)),
            ),
          ),
        ]),
      ),
    );
  }
}
