class ApiResponse<T> {
  T? data;
  bool result = true;
  String? msg;
  bool? isNextLink = true;

  ApiResponse({this.result = false, this.msg, this.data, this.isNextLink});
}
