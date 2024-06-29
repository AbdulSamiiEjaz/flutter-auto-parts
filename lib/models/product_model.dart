class ProductModel {
  final int partyTitle;
  final int itemcode;
  final String title;
  final double price;
  final int qty;
  final double totalAmount;

  ProductModel(
      {required this.itemcode,
      required this.title,
      required this.price,
      required this.qty,
      required this.totalAmount,
      required this.partyTitle});

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
        itemcode: json["itemcode"],
        title: json["title"],
        price: json["price"],
        qty: json["qty"],
        totalAmount: json["totalAmount"],
        partyTitle: json["partyTitle"]);
  }
}
