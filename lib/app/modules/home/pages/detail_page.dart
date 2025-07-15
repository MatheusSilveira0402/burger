import 'package:buger/app/core/size/extension_size.dart';
import 'package:buger/app/models/item_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';


class DetailPage extends StatelessWidget {
  const DetailPage({super.key});

  @override
  Widget build(BuildContext context) {
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
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                
              },
              child: const Text('Adicionar ao carrinho'),
            ),
          ],
        ),
      ),
    );
  }
}
