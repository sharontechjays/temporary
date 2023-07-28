class ApiResponse<T> {
  final T? data;
  final bool result;
  final String msg;
  final bool isNextLink;
  final int? statusCode;
  final dynamic responseData;

  ApiResponse({
    required this.result,
    required this.msg,
    required this.data,
    this.isNextLink = false,
    this.statusCode,
    this.responseData,
  });
}
