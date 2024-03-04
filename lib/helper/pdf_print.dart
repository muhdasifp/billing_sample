import 'dart:io';
import 'dart:typed_data';
import 'package:bill/model/item_model.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

class PrintPdfModel {
  ///calculate individual item total----->>>>>>>>>
  total(int index) {
    double itemTotal = 0.0;
    itemTotal += items[index].qty * items[index].price;
    return itemTotal;
  }

  /// calculate total amount----->>>>>>>>>
  calculateTotal() {
    double totalAmount = 0.0;
    for (var element in items) {
      totalAmount += element.qty * element.price;
    }
    return totalAmount;
  }

  /// calculate total quantity----->>>>>>>>>
  calculateQuantity() {
    double totalQty = 0.0;
    for (var element in items) {
      totalQty += element.qty;
    }
    return totalQty;
  }

  /// to save the pdf in local device----->>>>>>>>>
  Future<void> savePdf(String fileName, Uint8List byteList) async {
    final output = await getTemporaryDirectory();
    var filePath = '${output.path}/$fileName.pdf';
    final file = File(filePath);
    await file.writeAsBytes(byteList);
    await OpenFile.open(filePath);
  }

  ///this is the content of pdf ----->>>>>>>>>
  Future<Uint8List> generatePdf() async {
    final pdf = Document();

    pdf.addPage(
      MultiPage(
        build: (context) => [
          ListView(
            padding: const EdgeInsets.all(20),
            children: [
              header(),
              Divider(),
              productTableHeading(),
              productTableContent(),
            ],
          )
        ],
        footer: (context) => footerWidget(),
      ),
    );

    return pdf.save();
  }

  ///footer content
  Container footerWidget() {
    return Container(
      alignment: Alignment.bottomCenter,
      height: 100,
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          Divider(),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Total Qty:',
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
                  Text('Total Amount:',
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('${calculateQuantity()}',
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
                  Text('${calculateTotal()}',
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }

  ///customer
  static Widget customer() {
    return Column(mainAxisSize: MainAxisSize.min, children: [
      Text('Invoice Number'),
      Text('${DateTime.now()}'),
      Text('Customer Name'),
      Text('Customer Address'),
    ]);
  }

  ///company details
  static Widget companyLogo() {
    return Column(mainAxisSize: MainAxisSize.min, children: [
      SizedBox(height: 80, child: FlutterLogo()),
      Text('Company Name'),
      Text('Company Address'),
      Text('GST Number'),
    ]);
  }

  ///header
  static Widget header() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        companyLogo(),
        customer(),
      ],
    );
  }

  Widget productTableHeading() {
    return Table(
      children: [
        TableRow(
          decoration: const BoxDecoration(
            color: PdfColors.orange50,
          ),
          children: [
            Text('Sl'),
            Text('Item'),
            Text('Qty'),
            Text('Price'),
            Text('Total'),
          ],
        ),
      ],
    );
  }

  Widget productTableContent() {
    return Table(
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      border: const TableBorder(
        horizontalInside: BorderSide(
          color: PdfColors.teal50,
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
    );
  }
}
