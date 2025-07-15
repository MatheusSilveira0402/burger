import 'package:buger/app/core/size/extension_size.dart';
import 'package:buger/app/models/item_model.dart';
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
  late List<ItemModel> products = [];
  double total = 0.0;
  double rawTotal = 0.0;
  double discount = 0.0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    store = context.watch<ProductProvider>();
    products = store.productsBuy;
    rawTotal = products.fold(0.0, (sum, item) => sum + item.price);
    discount = 0.0;
    bool hasSandwich = products.any((item) => item.type == 'sandwich');
    bool hasFries = products.any((item) => item.name == 'Batata frita');
    bool hasDrink = products.any((item) => item.name == 'Refrigerante');

    if (hasSandwich && hasFries && hasDrink) {
      discount = 0.20;
    } else if (hasSandwich && hasDrink) {
      discount = 0.15;
    } else if (hasSandwich && hasFries) {
      discount = 0.10;
    }
    total = rawTotal * (1 - discount);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Carrinho'),
        leading: IconButton(
          icon: const Icon(Icons.home),
          onPressed: () {
            Modular.to.navigate('/');
          },
        ),
        excludeHeaderSemantics: false,
      ),
      body: SizedBox(
        width: context.widthPct(1),
        child: store.loading
            ? const Center(child: CircularProgressIndicator())
            : products.isEmpty
                ? const Center(child: Text('Nenhum item no carrinho'))
                : ListView.builder(
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      final item = products[index];
                      return ListTile(
                        title: Text(item.name),
                        subtitle: Text('R\$ ${item.price.toStringAsFixed(2)}'),
                        onTap: () {
                          store.removeCar(item);
                        },
                      );
                    },
                  ),
      ),
      floatingActionButton: GestureDetector(
        onTap: () {
          showDialog(
            context: context,
            builder: (_) {
              final TextEditingController controller = TextEditingController();
              return AlertDialog(
                title: const Text('Pagamento'),
                content: TextField(
                  controller: controller,
                  decoration: const InputDecoration(
                    labelText: 'Nome do cliente',
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context); // fecha modal
                    },
                    child: const Text('Cancelar'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      final name = controller.text.trim();
                      if (name.isEmpty) return;

                      store.clearCart(); // limpa carrinho
                      Navigator.pop(context); // fecha modal

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Pagamento confirmado!\nOriginal: R\$ ${rawTotal.toStringAsFixed(2)}\nDesconto: ${(discount * 100).toInt()}%\nTotal: R\$ ${total.toStringAsFixed(2)}',
                          ),
                        ),
                      );
                      Modular.to.navigate('/');
                    },
                    child: const Text('Confirmar pagamento'),
                  ),
                ],
              );
            },
          );
        },
        child: Container(
          margin: const EdgeInsets.only(left: 32),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            discount > 0
                ? 'Total: R\$ ${total.toStringAsFixed(2)} (${(discount * 100).toInt()}% off)'
                : 'Total: R\$ ${total.toStringAsFixed(2)}',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
