import 'package:flutter/material.dart';
import '../../../core/database/sqlite_service.dart';
import '../../../models/item_model.dart';

class ProductProvider extends ChangeNotifier {
  List<ItemModel> products = [];
  List<ItemModel> productsBuy = [];
  bool loading = false;
  double rawTotal = 0.0;
  double discount = 0.0;
  double total = 0.0;

  Future<void> loadProducts() async {
    loading = true;
    final db = await SqliteService.database;
    final result = await db.query('products');
    products = result.map((e) => ItemModel.fromMap(e)).toList();
    loading = false;
    notifyListeners();
  }

  Future<void> addCar(ItemModel item) async {
    final exists = productsBuy.any((element) => element.name == item.name);

    if (!exists) {
      productsBuy.add(item);
    } else {
      // Exemplo: lançar uma exceção ou chamar um callback de erro
      throw Exception('Item já adicionado ao carrinho');
    }
    notifyListeners();
  }

  Future<void> removeCar(ItemModel item) async {
    loading = true;
    final exists = productsBuy.any((element) => element.name == item.name);

    if (exists) {
      productsBuy.remove(item);
    } else {
      // Exemplo: lançar uma exceção ou chamar um callback de erro
      throw Exception('Item não existe no carrinho');
    }
    loading = false;
    notifyListeners();
  }

  Future<void> clearCart() async {
    productsBuy.clear();

    notifyListeners();
  }

  Future<void> applyDiscount() async {
    rawTotal = 0.0;
    discount = 0.0;
    total = 0.0;
    rawTotal = productsBuy.fold(0.0, (sum, item) => sum + item.price);
    bool hasSandwich = productsBuy.any((item) => item.type == 'sandwich');
    bool hasFries = productsBuy.any((item) => item.name == 'Batata frita');
    bool hasDrink = productsBuy.any((item) => item.name == 'Refrigerante');

    if (hasSandwich && hasFries && hasDrink) {
      discount = 0.20;
    } else if (hasSandwich && hasDrink) {
      discount = 0.15;
    } else if (hasSandwich && hasFries) {
      discount = 0.10;
    }
    total = rawTotal * (1 - discount);
    notifyListeners();
  }
}
