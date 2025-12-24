import 'package:desafio/app/domain/entities/product.dart';
import 'package:desafio/app/domain/usecases/get_products_usecase.dart';
import 'package:desafio/app/shared/utils/view_state.dart';
import 'package:flutter/material.dart';

class ProductsViewModel extends ChangeNotifier {
  final GetProductsUseCase _getProductsUseCase;

  ProductsViewModel(this._getProductsUseCase);

  List<Product> _products = [];
  List<Product> get products => _products;

  ViewState _state = ViewState.idle;
  ViewState get state => _state;

  String _errorMessage = '';
  String get errorMessage => _errorMessage;

  Future<void> fetchProducts() async {
    _state = ViewState.loading;
    notifyListeners();

    try {
      _products = await _getProductsUseCase();
      _state = ViewState.success;
    } catch (e) {
      _errorMessage = e.toString();
      _state = ViewState.error;
    } finally {
      notifyListeners();
    }
  }
}
