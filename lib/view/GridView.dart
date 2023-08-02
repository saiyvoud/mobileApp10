import 'package:flutter/material.dart';

class GridViewWidget extends StatelessWidget {
  const GridViewWidget({super.key});

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
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, childAspectRatio: 0.6),
        itemCount: 5,
        itemBuilder: (context, index) {
          return Card(
            child: Container(
              height: 150,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/images/phone.png",
                      fit: BoxFit.cover,
                    ),
                    SizedBox(height: 10),
                    Text("ຊື່: Oppo Pro"),
                    Text(
                      "ຈຳນວນ: 1",
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                    Text(
                      "ເວລາຈັດສົ່ງ: 01-08-2023",
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                    Text(
                      "ລາຄາ: 3,000,000 ₭",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ]),
            ),
          );
        },
      ),
    );
  }
}
