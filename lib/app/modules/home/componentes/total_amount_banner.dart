import 'package:flutter/material.dart';

class TotalAmountBanner extends StatelessWidget {
  final double total;
  final double discount;

  const TotalAmountBanner({
    super.key,
    required this.total,
    required this.discount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}
