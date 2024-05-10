
import 'dart:convert';

class ApiResponse {

    bool errored;
    String message;
    List<dynamic> data;

    ApiResponse({
      required this.errored,
      required this.message,
      required this.data
    });

    factory ApiResponse.fromJson(Map<String, dynamic> data) {
      return ApiResponse(
        errored: data["errored"] ?? true, 
        message: data["message"] ?? "", 
        data: data["data"] ?? []
      );
    }

    Map<String, dynamic> toJson() {
      return  {
        "errored": errored,
        "message": message,
        "data": data
      };
    }

    @override
    String toString() {
      return jsonEncode(toJson());
    }

  }