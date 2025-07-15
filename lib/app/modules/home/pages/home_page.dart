import 'package:buger/app/core/size/extension_size.dart';
import 'package:buger/app/modules/home/componentes/cart_item_title.dart';
import 'package:buger/app/modules/home/componentes/total_amount_banner.dart';
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
    final products = store.products.where((item) => item.type == 'sandwich').toList();
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(title: const Text('Bom Hambúrguer'), backgroundColor:  Color.fromARGB(255, 233, 117, 117),),
      body: Stack(
        children: [
          // Fundo vermelho clarinho com borda inferior arredondada
          Container(
            height: context.heightPct(0.25),
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 233, 117, 117), // vermelho bem claro
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(32),
              ),
            ),
          ),
          // Conteúdo principal
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: products.isEmpty
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    padding: const EdgeInsets.only(top: 16),
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      final item = products[index];
                      return CartItemTile(
                        item: item,
                        onChange: () => Modular.to.pushNamed('/detail', arguments: item),
                        icon: Icons.arrow_forward_ios,
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: store.productsBuy.isNotEmpty
          ? GestureDetector(
              onTap: () {
                Modular.to.pushNamed('/car');
              },
              child: TotalAmountBanner(
                total: store.total,
                discount: store.discount,
              ),
            )
          : null,
    );
  }
}
