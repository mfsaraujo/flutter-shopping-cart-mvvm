import '../../models/product_model.dart';

abstract class IProductDatasource {
  Future<List<ProductModel>> getProducts();
}
