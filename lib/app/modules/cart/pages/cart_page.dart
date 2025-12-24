import 'package:desafio/app/domain/entities/cart_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/cart_viewmodel.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cartVM = context.watch<CartViewModel>();

    return Scaffold(
      appBar: AppBar(title: const Text('Meu Carrinho')),
      body: cartVM.items.isEmpty
          ? const Center(child: Text('Carrinho Vazio'))
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cartVM.items.length,
                    itemBuilder: (context, index) {
                      final item = cartVM.items[index];
                      return ListTile(
                        leading: Image.network(item.product.image, width: 50),
                        title: Text(item.product.title),
                        subtitle: Text(
                          '${item.quantity}x R\$ ${item.product.price} = R\$ ${item.subtotal.toStringAsFixed(2)}',
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () async {
                            try {
                              await cartVM.removeItemWithServerError(
                                item.product.id,
                              );
                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'Erro simulado: Falha ao remover item!',
                                  ),
                                ),
                              );
                            }
                          },
                        ),
                      );
                    },
                  ),
                ),
                _buildSummary(context, cartVM),
              ],
            ),
    );
  }

  Widget _buildSummary(BuildContext context, CartViewModel vm) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: Colors.grey[200]),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Total:'),
              Text(
                'R\$ ${vm.total.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () async {
                final itemsSnapshot = List<CartItem>.from(vm.items);
                final success = await vm.checkout();
                if (success) {
                  Navigator.pushNamed(
                    context,
                    '/success',
                    arguments: itemsSnapshot,
                  );
                }
              },
              child: const Text('Finalizar Pedido'),
            ),
          ),
        ],
      ),
    );
  }
}
