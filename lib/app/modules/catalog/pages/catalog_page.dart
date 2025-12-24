import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/products_viewmodel.dart';
import '../../cart/viewmodels/cart_viewmodel.dart';
import '../../../shared/utils/view_state.dart';

class CatalogPage extends StatefulWidget {
  const CatalogPage({super.key});

  @override
  State<CatalogPage> createState() => _CatalogPageState();
}

class _CatalogPageState extends State<CatalogPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProductsViewModel>().fetchProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    final productsVM = context.watch<ProductsViewModel>();
    final cartVM = context.watch<CartViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Loja Flutter'),
        actions: [_CartBadge(count: cartVM.totalItemsCount)],
      ),
      body: _buildBody(productsVM, cartVM),
    );
  }

  Widget _buildBody(ProductsViewModel vm, CartViewModel cartVM) {
    if (vm.state == ViewState.loading)
      return const Center(child: CircularProgressIndicator());
    if (vm.state == ViewState.error)
      return Center(child: Text(vm.errorMessage));

    return GridView.builder(
      padding: const EdgeInsets.all(10),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.7,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: vm.products.length,
      itemBuilder: (context, index) {
        final product = vm.products[index];
        final quantity = cartVM.getProductQuantity(product.id);

        return Card(
          child: Column(
            children: [
              Expanded(
                child: Image.network(product.image, fit: BoxFit.contain),
              ),
              Text(product.title, maxLines: 2, textAlign: TextAlign.center),
              Text('R\$ ${product.price.toStringAsFixed(2)}'),
              const SizedBox(height: 8),

              quantity == 0
                  ? ElevatedButton(
                      onPressed: () =>
                          _handleAddToCart(context, cartVM, product),
                      child: const Text('Adicionar'),
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.remove),
                          onPressed: () => cartVM.removeFromCart(product.id),
                        ),
                        Text('$quantity'),
                        IconButton(
                          icon: const Icon(Icons.add),
                          onPressed: () =>
                              _handleAddToCart(context, cartVM, product),
                        ),
                      ],
                    ),
            ],
          ),
        );
      },
    );
  }

  void _handleAddToCart(BuildContext context, CartViewModel cartVM, product) {
    try {
      cartVM.addToCart(product);
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }
}

class _CartBadge extends StatelessWidget {
  final int count;
  const _CartBadge({required this.count});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        IconButton(
          icon: const Icon(Icons.shopping_cart),
          onPressed: () => Navigator.pushNamed(context, '/cart'),
        ),
        if (count > 0)
          Positioned(
            right: 8,
            top: 8,
            child: CircleAvatar(
              radius: 8,
              backgroundColor: Colors.red,
              child: Text(
                '$count',
                style: const TextStyle(fontSize: 10, color: Colors.white),
              ),
            ),
          ),
      ],
    );
  }
}
