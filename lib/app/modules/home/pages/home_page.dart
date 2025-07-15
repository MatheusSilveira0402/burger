import 'package:buger/app/modules/home/provider/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late ProductProvider store;

  @override
  void initState() {
    super.initState();
    context.read<ProductProvider>().loadProducts();
  }

  @override
  Widget build(BuildContext context) {
    store = context.watch<ProductProvider>();
    final products = store.products;

    return Scaffold(
      appBar: AppBar(title: const Text('Bom Hambúrguer')),
      body: products.isEmpty
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
    );
  }
}
