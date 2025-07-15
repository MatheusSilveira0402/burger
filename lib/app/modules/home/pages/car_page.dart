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
    final products = store.productsBuy;
    double rawTotal = products.fold(0.0, (sum, item) => sum + item.price);

// Verifica se tem pelo menos um item do tipo
    bool hasSandwich = products.any((item) => item.type == 'sandwich');
    bool hasFries = products.any((item) => item.name == 'Batata frita');
    bool hasDrink = products.any((item) => item.name == 'Refrigerante');

    double discount = 0.0;

    if (hasSandwich && hasFries && hasDrink) {
      discount = 0.20;
    } else if (hasSandwich && hasDrink) {
      discount = 0.15;
    } else if (hasSandwich && hasFries) {
      discount = 0.10;
    }

    double total = rawTotal * (1 - discount);
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

                      // Aqui você pode salvar o pedido no banco se quiser

                      store.clearCart(); // limpa carrinho
                      Navigator.pop(context); // fecha modal
                      Modular.to.pushNamed('/');
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                              'Pagamento de R\$ ${total.toStringAsFixed(2)} confirmado para $name!'),
                        ),
                      );
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
            'Total: R\$ ${total.toStringAsFixed(2)}',
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
