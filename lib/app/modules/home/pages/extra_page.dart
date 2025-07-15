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
    final extras = store.products.where((item) => item.type == 'extra').toList();

    return SizedBox(
      width: context.widthPct(1),
      height: context.heightPct(0.3),
      child: ListView.builder(
        itemCount: extras.length,
        itemBuilder: (context, index) {
          final item = extras[index];
          final isSelected = store.productsBuy.any((e) => e.name == item.name);

          return Card(
            elevation: 3,
            color: isSelected ? Colors.red.shade50 : Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: BorderSide(
                color: isSelected ? Colors.red : Colors.grey.shade300,
                width: 1.2,
              ),
            ),
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              title: Text(
                item.name,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              subtitle: Text(
                'R\$ ${item.price.toStringAsFixed(2)}',
                style: const TextStyle(color: Colors.grey),
              ),
              trailing: Icon(
                isSelected ? Icons.check_circle : Icons.add_circle_outline,
                color: isSelected ? Colors.red : Colors.grey,
              ),
              onTap: () {
                setState(() {
                  if (isSelected) {
                    store.removeCar(item);
                  } else {
                    store.addCar(item);
                  }
                });
              },
            ),
          );
        },
      ),
    );
  }
}
