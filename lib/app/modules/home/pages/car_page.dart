import 'package:buger/app/core/size/extension_size.dart';
import 'package:buger/app/modules/home/provider/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class CarPage extends StatefulWidget {
  const CarPage({super.key});

  @override
  State<CarPage> createState() => _CarPageState();
}

class _CarPageState extends State<CarPage> {
  late ProductProvider store;
  
  @override
  Widget build(BuildContext context) {
    store = context.watch<ProductProvider>();
    final products = store.products;
    return Scaffold(
      body: SizedBox(
        width: context.widthPct(1),
        child: products.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                final item = products[index];
                return ListTile(
                  title: Text(item.name),
                  subtitle: Text('R\$ ${item.price.toStringAsFixed(2)}'),
                  onTap: () {
                    Modular.to.pushNamed('/detail', arguments: item);
                  },
                );
              },
            ),
      ),
    );
  }
}