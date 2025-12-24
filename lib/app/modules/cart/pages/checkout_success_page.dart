import 'package:flutter/material.dart';
import '../../../domain/entities/cart_item.dart';

class CheckoutSuccessPage extends StatelessWidget {
  const CheckoutSuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    const double simulatedFreight = 15.0;

    final List<CartItem> orderedItems =
        ModalRoute.of(context)!.settings.arguments as List<CartItem>;

    final double subtotal = orderedItems.fold(
      0,
      (sum, item) => sum + item.subtotal,
    );
    final double total = subtotal + simulatedFreight;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pedido Finalizado'),
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Icon(
              Icons.check_circle_outline,
              color: Colors.green,
              size: 80,
            ),
          ),
          const Text(
            'Sucesso! Seu pedido foi realizado.',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),

          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: orderedItems.length,
              itemBuilder: (context, index) {
                final item = orderedItems[index];
                return ListTile(
                  leading: Image.network(item.product.image, width: 40),
                  title: Text(
                    item.product.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  subtitle: Text(
                    '${item.quantity}x R\$ ${item.product.price.toStringAsFixed(2)}',
                  ),
                  trailing: Text('R\$ ${item.subtotal.toStringAsFixed(2)}'),
                );
              },
            ),
          ),

          _buildOrderSummary(subtotal, simulatedFreight, total, context),
        ],
      ),
    );
  }

  Widget _buildOrderSummary(
    double subtotal,
    double freight,
    double total,
    BuildContext context,
  ) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, -5),
          ),
        ],
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _rowSummary('Subtotal', subtotal),
            _rowSummary('Frete (Simulado)', freight),
            const Divider(),
            _rowSummary('Total', total, isTotal: true),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                ),
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    '/',
                    (route) => false,
                  );
                },
                child: const Text('NOVO PEDIDO'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _rowSummary(String label, double value, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: isTotal ? 18 : 14,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          Text(
            'R\$ ${value.toStringAsFixed(2)}',
            style: TextStyle(
              fontSize: isTotal ? 18 : 14,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
