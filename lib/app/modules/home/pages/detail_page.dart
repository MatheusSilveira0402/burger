import 'package:buger/app/core/size/extension_size.dart';
import 'package:buger/app/models/item_model.dart';
import 'package:buger/app/modules/home/pages/extra_page.dart';
import 'package:buger/app/modules/home/provider/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';


class DetailPage extends StatefulWidget {
  const DetailPage({super.key});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  late ProductProvider store;
  late ItemModel product;

  @override
  void initState() {
    super.initState();
    store = context.read<ProductProvider>();
    product = Modular.args.data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: context.widthPct(1),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(product.name, style: const TextStyle(fontSize: 24)),
            Text('R\$ ${product.price.toStringAsFixed(2)}'),
            const ExtraPage(),
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