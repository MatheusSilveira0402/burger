import 'package:buger/app/models/item_model.dart';
import 'package:flutter/material.dart';

class CartItemTile extends StatelessWidget {
  final ItemModel item;
  final void Function() onChange; // ✅ alterado aqui
  final IconData? icon;

  const CartItemTile({
    super.key,
    required this.item,
    required this.onChange,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        title: Text(
          item.name,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        subtitle: Text(
          'R\$ ${item.price.toStringAsFixed(2)}',
          style: const TextStyle(color: Colors.grey),
        ),
        trailing: icon != null
            ? IconButton(
                icon: Icon(icon, color: Colors.red),
                onPressed: onChange,
              )
            : null,
        onTap: onChange, // ✅ permite também tocar o card inteiro
      ),
    );
  }
}
