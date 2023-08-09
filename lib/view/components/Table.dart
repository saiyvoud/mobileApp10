import 'package:flutter/material.dart';

class TableWidget extends StatefulWidget {
  const TableWidget({super.key});

  @override
  State<TableWidget> createState() => _TableWidgetState();
}

class _TableWidgetState extends State<TableWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: DataTable(
        
        // headingRowColor: MaterialStateColor.resolveWith((states) => Colors.blue.shade800),
        //   dataRowColor: MaterialStateColor.resolveWith((states) => Colors.red),
         decoration: BoxDecoration(border: Border.all(  )),
          columns: [
            DataColumn(
              label: Text('ID'),
            ),
            DataColumn(
              label: Text('Name'),
            ),
            DataColumn(
              label: Text('Code'),
            ),
            DataColumn(
              label: Text('Quantity'),
            ),
            DataColumn(
              label: Text('Amount'),
            ),
          ],
          rows: [
            DataRow(cells: [
              DataCell(Text('1')),
              DataCell(Text('Arshik')),
              DataCell(Text('5644645')),
              DataCell(Text('3')),
              DataCell(Text('265\$')),
            ])
          ]),
    );
    // return Table(
    //     columnWidths: {
    //       0: FixedColumnWidth(100),
    //       1: FixedColumnWidth(120),
    //       2: FixedColumnWidth(100),
    //     },
    //     border: TableBorder
    //         .all(), // Allows to add a border decoration around your table
    //     children: [
    //       TableRow(children: [
    //         Text('Year'),
    //         Text('Lang'),
    //         Text('Author'),
    //       ]),
    //       TableRow(children: [
    //         Text(
    //           '2011',
    //         ),
    //         Text('Dart'),
    //         Text('Lars Bak'),
    //       ]),
    //       TableRow(children: [
    //         Text('1996'),
    //         Text('Java'),
    //         Text('James Gosling'),
    //       ]),
    //     ]);
  }
}
