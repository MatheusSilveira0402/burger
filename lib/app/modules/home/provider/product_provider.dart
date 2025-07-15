import 'package:flutter/material.dart';
import '../../../core/database/sqlite_service.dart';
import '../../../models/item_model.dart';

class ProductProvider extends ChangeNotifier {
  List<ItemModel> products = [];
  List<ItemModel> productsBuy = [];
  bool loading = false;

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
}
