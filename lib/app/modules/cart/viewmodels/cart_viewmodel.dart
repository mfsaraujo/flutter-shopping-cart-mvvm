import 'package:desafio/app/domain/entities/cart_item.dart';
import 'package:desafio/app/domain/entities/product.dart';
import 'package:desafio/app/domain/usecases/add_item_to_cart_usecase.dart';
import 'package:desafio/app/domain/usecases/remove_item_from_cart_usecase.dart';
import 'package:desafio/app/infra/services/checkout_service.dart';
import 'package:flutter/material.dart';

class CartViewModel extends ChangeNotifier {
  final AddItemToCartUseCase _addUseCase;
  final RemoveItemFromCartUseCase _removeUseCase;
  final CheckoutService _checkoutService;

  CartViewModel(this._addUseCase, this._removeUseCase, this._checkoutService);

  List<CartItem> _items = [];
  List<CartItem> get items => _items;

  double get total => _items.fold(0, (sum, item) => sum + item.subtotal);
  int get totalItemsCount =>
      _items.fold(0, (count, item) => count + item.quantity);

  void addToCart(Product product) {
    try {
      _items = _addUseCase(_items, product);
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  void removeFromCart(int productId) {
    _items = _removeUseCase(_items, productId);
    notifyListeners();
  }

  Future<void> removeItemWithServerError(int productId) async {
    try {
      await _checkoutService.simulateRemoveError();
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> checkout() async {
    final success = await _checkoutService.finalizeOrder();
    if (success) {
      _items = [];
      notifyListeners();
    }
    return success;
  }

  int getProductQuantity(int productId) {
    final index = _items.indexWhere((item) => item.product.id == productId);
    return index != -1 ? _items[index].quantity : 0;
  }
}
