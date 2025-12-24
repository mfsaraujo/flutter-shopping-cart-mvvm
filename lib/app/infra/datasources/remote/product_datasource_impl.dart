import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../models/product_model.dart';
import '../../../domain/errors/errors.dart';
import 'i_product_datasource.dart';

class ProductDatasourceImpl implements IProductDatasource {
  final http.Client client;
  final String baseUrl = 'https://fakestoreapi.com/products';

  ProductDatasourceImpl(this.client);

  @override
  Future<List<ProductModel>> getProducts() async {
    try {
      final response = await client.get(Uri.parse(baseUrl));

      if (response.statusCode == 200) {
        final List list = jsonDecode(response.body);
        return ProductModel.fromJsonList(list);
      } else {
        throw ServerFailure('Erro ao buscar produtos: ${response.statusCode}');
      }
    } catch (e) {
      throw DatasourceFailure('Erro de conexão ou parse: $e');
    }
  }
}
