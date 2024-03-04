import 'package:bill/model/item_model.dart';
import 'package:flutter/material.dart';

class TableProvider extends ChangeNotifier {
  TextEditingController item = TextEditingController();
  TextEditingController qty = TextEditingController();
  TextEditingController price = TextEditingController();
  int index = 0;

  addToTable() {
    if (item.text.isNotEmpty && qty.text.isNotEmpty && price.text.isNotEmpty) {
      items.add(
        ItemModel(
          sl: index,
          item: item.text,
          qty: int.parse(qty.text),
          price: double.parse(price.text),
        ),
      );
      item.clear();
      qty.clear();
      price.clear();
      index++;
    }
    notifyListeners();
  }
}
