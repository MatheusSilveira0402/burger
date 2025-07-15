import 'package:buger/app/core/size/extension_size.dart';
import 'package:buger/app/models/item_model.dart';
import 'package:buger/app/modules/home/componentes/cart_item_title.dart';
import 'package:buger/app/modules/home/componentes/total_amount_banner.dart';
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
  
  @override
  Widget build(BuildContext context) {
    store = context.watch<ProductProvider>();
    products = store.productsBuy;
    store.applyDiscount();
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
                      return CartItemTile(item: item, onChange: () => store.removeCar(item), icon: Icons.delete_forever,);
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
                actionsPadding: EdgeInsets.all(15),
                title: Text(
                  'Pagamento',
                  style: TextStyle(color: Colors.grey[700]),
                ),
                contentPadding: EdgeInsets.all(15),
                content: SizedBox(
                  width: context.widthPct(0.66),
                  child: TextField(
                    controller: controller,
                    decoration: InputDecoration(
                      labelText: 'Nome do cliente',
                      labelStyle: TextStyle(color: Colors.grey[600]),
                      enabledBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        borderSide: BorderSide(color: Color.fromARGB(255, 233, 117, 117)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        borderSide: BorderSide(
                            color: const Color.fromARGB(255, 233, 117, 117), width: 2),
                      ),
                    ),
                  ),
                ),
                actionsAlignment: MainAxisAlignment.spaceBetween,
                actions: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: context.widthPct(0.33),
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: Colors.red),
                            foregroundColor: Colors.red,
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('Cancelar',
                              style: TextStyle(fontSize: context.heightPct(0.014))),
                        ),
                      ),
                      SizedBox(
                        width: context.widthPct(0.33),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            foregroundColor: Colors.white,
                          ),
                          onPressed: () {
                            final name = controller.text.trim();
                            if (name.isEmpty) return;

                            store.clearCart();
                            Navigator.pop(context);

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'Pagamento confirmado!\nOriginal: R\$ ${store.rawTotal.toStringAsFixed(2)}\nDesconto: ${(store.discount * 100).toInt()}%\nTotal: R\$ ${store.total.toStringAsFixed(2)}',
                                ),
                              ),
                            );
                            Modular.to.navigate('/');
                          },
                          child: Text(
                            'Pagar',
                            style: TextStyle(fontSize: context.heightPct(0.014)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              );
            },
          );
        },
        child: TotalAmountBanner(total: store.total, discount: store.discount),
      ),
    );
  }
}
