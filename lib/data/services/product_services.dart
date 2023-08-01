import '../models/api_response.dart';
import '../models/products_model.dart';
import '../network_service/rest_client.dart';

class ProductServices {
  String products = 'products';

  Future<ApiResponse<ProductsModel>> getProducts() async {
    var qP = {'param': '123', 'param2': 'abcd'};
    var dioClient = RestClient();
    return dioClient.getRequest<ProductsModel>(
      endpoint: products,
      fromJson: (json) => ProductsModel.fromJson(json),
      queryParameters: null
    );
  }
}
