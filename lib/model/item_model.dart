class ItemModel {
  final int? sl;
  final String item;
  final int qty;
  final double price;

  ItemModel({
    this.sl,
    required this.item,
    required this.qty,
    required this.price,
  });
}

List<ItemModel> items = [];
