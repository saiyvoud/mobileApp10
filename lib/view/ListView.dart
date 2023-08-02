import 'package:flutter/material.dart';

class ListViewWidget extends StatelessWidget {
  const ListViewWidget({super.key});

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
     
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return Card(
            elevation: 3,
            child: Container(
              height: 120,
              width: double.infinity,
              child: Row(children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(
                    "assets/images/phone.png",
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(width: 10),
                Container(
                  height: 110,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
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
                )
              ]),
            ),
          );
        },
      ),
    );
  }
}
