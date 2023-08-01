import 'package:dio/dio.dart';

import '../models/api_response.dart';
import '../models/products_model.dart';
import '../network_service/rest_client.dart';

class ProductServices {
  String products = 'products';
  String upload = 'products';
  var dioClient = RestClient();

  Future<ApiResponse<ProductsModel>> getProducts() async {
    var qP = {'param': '123', 'param2': 'abcd'};
    return dioClient.getRequest<ProductsModel>(
        endpoint: products,
        fromJson: (json) => ProductsModel.fromJson(json),
        queryParameters: null);
  }

  Future<Response> sendTheFile(String filePath) async {
    return dioClient.uploadFileWithProgress(
        "", upload, (sentBytes, totalBytes) => null);
  }
}
