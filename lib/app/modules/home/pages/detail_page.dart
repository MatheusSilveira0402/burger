import 'package:buger/app/core/size/extension_size.dart';
import 'package:buger/app/models/item_model.dart';
import 'package:buger/app/modules/home/pages/extra_page.dart';
import 'package:buger/app/modules/home/provider/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';


class DetailPage extends StatelessWidget {
  const DetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    ProductProvider store = context.watch<ProductProvider>();
    final ItemModel product = Modular.args.data;
    return Scaffold(
      body: SizedBox(
        width: context.widthPct(1),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(product.name, style: const TextStyle(fontSize: 24)),
            Text('R\$ ${product.price.toStringAsFixed(2)}'),
            ExtraPage(),
            ElevatedButton(
              onPressed: () {
                store.addCar(product);
                Modular.to.pushNamed('/car');
              },
              child: const Text('Adicionar ao carrinho'),
            ),
          ],
        ),
      ),
    );
  }
}
