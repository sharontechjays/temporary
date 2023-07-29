import 'package:test_flutter/models/api_response.dart';
import 'package:test_flutter/models/products_model.dart';
import 'package:test_flutter/network_service/rest_client.dart';

class ProductServices {
  String products = 'products';

  Future<ApiResponse<ProductsModel>> getProducts() async {
    var dioClient = RestClient();
    return dioClient.getRequest<ProductsModel>(
      endpoint: products,
      fromJson: (json) => ProductsModel.fromJson(json),
    );
  }
}
