import '../entities/cart_item.dart';
import '../entities/product.dart';
import '../errors/errors.dart';

class AddItemToCartUseCase {
  static const int maxDifferentProducts = 10;

  List<CartItem> call(List<CartItem> currentItems, Product product) {
    final index = currentItems.indexWhere(
      (item) => item.product.id == product.id,
    );

    if (index != -1) {
      final updatedItem = currentItems[index].copyWith(
        quantity: currentItems[index].quantity + 1,
      );

      final newList = List<CartItem>.from(currentItems);
      newList[index] = updatedItem;
      return newList;
    } else {
      if (currentItems.length >= maxDifferentProducts) {
        throw BusinessFailure(
          'O carrinho não pode ter mais de $maxDifferentProducts produtos diferentes.',
        );
      }

      return [...currentItems, CartItem(product: product, quantity: 1)];
    }
  }
}
