import 'package:bill/controller/table_provider.dart';
import 'package:bill/model/item_model.dart';
import 'package:bill/helper/pdf_print.dart';
import 'package:bill/presentation/view/print_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final tab = Provider.of<TableProvider>(context);
    FocusNode itemNode = FocusNode();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Company Name'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const PrintPage(),
                ),
              );
            },
            icon: const Icon(
              Icons.print,
              size: 35,
            ),
          ),
          IconButton(
            onPressed: () async {
              var data = await PrintPdfModel().generatePdf();
              PrintPdfModel().savePdf('sample', data);
            },
            icon: const Icon(
              Icons.download,
              size: 30,
            ),
          )
        ],
      ),
      body: ListView.builder(
        shrinkWrap: true,
        padding: const EdgeInsets.all(30),
        itemCount: items.length,
        itemBuilder: (context, index) {
          return Table(
            children: [
              TableRow(
                children: [
                  Text("${index + 1}"),
                  Text(items[index].item),
                  Text(items[index].qty.toString()),
                  Text(items[index].price.toString()),
                ],
              ),
            ],
          );
        },
      ),
      floatingActionButton: Container(
        margin: const EdgeInsets.fromLTRB(20, 0, 20, 50),
        height: 40,
        width: double.infinity,
        child: Table(
          children: [
            TableRow(
              children: [
                SizedBox(
                  height: 40,
                  child: TextField(
                    focusNode: itemNode,
                    onEditingComplete: () => FocusScope.of(context).nextFocus(),
                    controller: tab.item,
                    decoration: const InputDecoration(
                      hintText: 'Items',
                    ),
                  ),
                ),
                SizedBox(
                  height: 40,
                  child: TextField(
                    onEditingComplete: () => FocusScope.of(context).nextFocus(),
                    controller: tab.qty,
                    decoration: const InputDecoration(
                      hintText: 'Quantity',
                    ),
                  ),
                ),
                SizedBox(
                  height: 40,
                  child: TextField(
                    onSubmitted: (value) {
                      tab.addToTable();
                      FocusScope.of(context).requestFocus(itemNode);
                    },
                    controller: tab.price,
                    decoration: const InputDecoration(
                      hintText: 'Unit Price',
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
