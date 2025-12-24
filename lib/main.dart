import 'package:desafio/app/domain/usecases/add_item_to_cart_usecase.dart';
import 'package:desafio/app/domain/usecases/get_products_usecase.dart';
import 'package:desafio/app/domain/usecases/remove_item_from_cart_usecase.dart';
import 'package:desafio/app/infra/datasources/remote/product_datasource_impl.dart';
import 'package:desafio/app/infra/repositories/product_repository_impl.dart';
import 'package:desafio/app/infra/services/checkout_service.dart';
import 'package:desafio/app/modules/cart/pages/cart_page.dart';
import 'package:desafio/app/modules/cart/pages/checkout_success_page.dart';
import 'package:desafio/app/modules/cart/viewmodels/cart_viewmodel.dart';
import 'package:desafio/app/modules/catalog/pages/catalog_page.dart';
import 'package:desafio/app/modules/catalog/viewmodels/products_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

void main() {
  final httpClient = http.Client();
  final productDatasource = ProductDatasourceImpl(httpClient);
  final productRepository = ProductRepositoryImpl(productDatasource);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => CartViewModel(
            AddItemToCartUseCase(),
            RemoveItemFromCartUseCase(),
            CheckoutService(),
          ),
        ),
        ChangeNotifierProvider(
          create: (_) =>
              ProductsViewModel(GetProductsUseCase(productRepository)),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Shopping Cart',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
      initialRoute: '/',
      routes: {
        '/': (context) => const CatalogPage(),
        '/cart': (context) => const CartPage(),
        '/success': (context) => const CheckoutSuccessPage(),
      },
    );
  }
}
