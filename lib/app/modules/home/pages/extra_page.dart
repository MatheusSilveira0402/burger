import 'package:buger/app/core/size/extension_size.dart';
import 'package:buger/app/modules/home/provider/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ExtraPage extends StatefulWidget {
  const ExtraPage({super.key});

  @override
  State<ExtraPage> createState() => _ExtraPageState();
}

class _ExtraPageState extends State<ExtraPage> {
  late ProductProvider store;
  @override
  Widget build(BuildContext context) {
    store = context.watch<ProductProvider>();

    final products = store.products.where((item) => item.type == 'extra').toList();
    return SizedBox(
      width: context.widthPct(1),
      height: context.heightPct(0.3),
      child: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          final item = products[index];
          return ListTile(
            title: Text(item.name),
            subtitle: Text('R\$ ${item.price.toStringAsFixed(2)}'),
            selected: store.productsBuy.any(
              (element) => element.name == item.name,
            ),
            onTap: () {
              if (store.productsBuy.any(
                (element) => element.name == item.name,
              )) {
                store.removeCar(item);
              } else {
                store.addCar(item);
              }
            },
          );
        },
      ),
    );
  }
}
