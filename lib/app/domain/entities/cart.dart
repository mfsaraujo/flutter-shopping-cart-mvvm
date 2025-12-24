import 'cart_item.dart';

class Cart {
  final List<CartItem> items;

  const Cart({this.items = const []});

  double get total => items.fold(0, (sum, item) => sum + item.subtotal);

  int get totalItemsCount =>
      items.fold(0, (count, item) => count + item.quantity);

  bool get isEmpty => items.isEmpty;
}
