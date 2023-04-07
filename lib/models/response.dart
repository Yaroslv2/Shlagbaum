class MyResponse {
  dynamic? body;
  int statusCode;
  String? errorMessage;

  MyResponse(this.body, this.statusCode);

  MyResponse.withError(this.errorMessage, this.statusCode);
}
