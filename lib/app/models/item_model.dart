class ItemModel {
  final String name;
  final double price;
  final String type;

  ItemModel({required this.name, required this.price, required this.type});

  Map<String, dynamic> toMap() => {
        'name': name,
        'price': price,
        'type': type,
      };

  factory ItemModel.fromMap(Map<String, dynamic> map) => ItemModel(
        name: map['name'],
        price: map['price'],
        type: map['type'],
      );
}