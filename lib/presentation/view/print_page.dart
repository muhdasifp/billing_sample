import 'package:bill/model/item_model.dart';
import 'package:bill/helper/pdf_print.dart';
import 'package:flutter/material.dart';
import 'package:printing/printing.dart';

class PrintPage extends StatelessWidget {
  const PrintPage({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    total(int index) {
      double totalAmount = 0;
      totalAmount += items[index].qty * items[index].price;
      return totalAmount;
    }

    sub() {
      double sum = 0;
      for (var element in items) {
        sum += element.qty * element.price;
      }
      return sum;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Invoice'),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 18.0),
            child: MaterialButton(
              height: 40,
              onPressed: () async {
                await Printing.layoutPdf(onLayout: (format) {
                  return PrintPdfModel().generatePdf();
                });
              },
              hoverColor: Colors.green,
              color: Colors.blue[400],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Text(
                'Print',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          )
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          SizedBox(
            height: height * 0.15,
            width: width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Column(
                  children: [
                    FlutterLogo(size: 50),
                    SizedBox(height: 10),
                    Text('Company Name'),
                    Text('Company Address'),
                  ],
                ),
                Column(
                  children: [
                    const Text('Invoice Number'),
                    Text('${DateTime.now()}'),
                    const Text('Customer Name'),
                    const Text('Customer Address'),
                  ],
                )
              ],
            ),
          ),
          const Divider(),
          Table(
            children: [
              TableRow(
                decoration: BoxDecoration(
                  color: Colors.orange.shade50,
                ),
                children: const [
                  Text('Sl'),
                  Text('Item'),
                  Text('Qty'),
                  Text('Price'),
                  Text('Total'),
                ],
              ),
            ],
          ),
          Table(
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            border: TableBorder(
              horizontalInside: BorderSide(
                color: Colors.teal.shade50,
              ),
            ),
            children: List.generate(
              items.length,
              (index) => TableRow(
                children: [
                  Text('${index + 1}'),
                  Text(items[index].item),
                  Text('${items[index].qty}'),
                  Text('${items[index].price}'),
                  Text('${total(index)}')
                ],
              ),
            ),
          ),
          // DataTable(
          //   headingRowColor: const MaterialStatePropertyAll(Color(0xffFEE295)),
          //   headingTextStyle: const TextStyle(
          //     fontSize: 20,
          //     fontWeight: FontWeight.bold,
          //   ),
          //   border: const TableBorder(
          //     verticalInside: BorderSide(color: Colors.teal),
          //   ),
          //   columns: const [
          //     DataColumn(label: Text('Sl')),
          //     DataColumn(label: Text('Item')),
          //     DataColumn(label: Text('Qty')),
          //     DataColumn(label: Text('Price')),
          //     DataColumn(label: Text('Total')),
          //   ],
          //   rows: List.generate(items.length, (index) {
          //     return DataRow(
          //       cells: [
          //         DataCell(Text('${index + 1}')),
          //         DataCell(Text(items[index].item)),
          //         DataCell(Text(items[index].qty.toString())),
          //         DataCell(Text(items[index].price.toString())),
          //         DataCell(Text('${total(index)}')),
          //       ],
          //     );
          //   }),
          // ),

          const SizedBox(height: 20),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Text('SubTotal: '),
              Text(sub().toString()),
            ],
          )
        ],
      ),
    );
  }
}
