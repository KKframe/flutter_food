class ApiResult {
  final String status;
  final String? message;
  final dynamic data;

  ApiResult({
    required this.status,
    required this.message,
    required this.data,
  });

  factory ApiResult.fromJson(Map<String, dynamic> json) {
    return ApiResult(
      status: json['status'],
      message: json['message'],
      data: json['data'],
    );
  }
}
/*
ApiResult.fromJson  เป็น named constructor

เมื่อไรที่ constructor มี factory เราจะต้องมีการ return ด้วย
*/
