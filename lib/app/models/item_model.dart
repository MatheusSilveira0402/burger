class ItemModel {
  final String name;
  final double price;

  ItemModel({required this.name, required this.price});

  Map<String, dynamic> toMap() => {
        'name': name,
        'price': price,
      };

  factory ItemModel.fromMap(Map<String, dynamic> map) => ItemModel(
        name: map['name'],
        price: map['price'],
      );
}
