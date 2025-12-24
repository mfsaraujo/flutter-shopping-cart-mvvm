import '../entities/cart_item.dart';

class RemoveItemFromCartUseCase {
  List<CartItem> call(List<CartItem> currentItems, int productId) {
    final index = currentItems.indexWhere(
      (item) => item.product.id == productId,
    );

    if (index == -1) return currentItems;

    final item = currentItems[index];
    final newList = List<CartItem>.from(currentItems);

    if (item.quantity > 1) {
      newList[index] = item.copyWith(quantity: item.quantity - 1);
    } else {
      newList.removeAt(index);
    }

    return newList;
  }
}
