
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

import '../model/api_response.dart';
import 'dart:io' show Platform;

enum Protocol {
  http, https, wss, ws
}

final String _serviceDomain = Platform.isAndroid || Platform.isIOS ? "10.0.2.2:8080" : "localhost:8080";

Uri _buildRoute(String urlPath, {Protocol protocol = Protocol.http, String domain = ""}) {
  domain = domain.isEmpty ? _serviceDomain : domain;
  return Uri.parse("${protocol.name}://$domain/$urlPath");
}

class HttpService {

  static Future<ApiResponse> getRequest(String urlPath, {Protocol protocol = Protocol.http, String domain = ""}) async {
    debugPrint("route => ${_buildRoute(urlPath, protocol: protocol, domain: domain)}");
    try {
      final response = await get(_buildRoute(urlPath, protocol: protocol, domain: domain));
      return ApiResponse.fromJson({
        "errored": false,
        "message": "",
        "data": [jsonDecode(response.body)]
      });
    } catch(e) {
      debugPrint(e.toString());
      return ApiResponse.fromJson({"errored": true, "message": e.toString()});
    }
  }

  static Future<ApiResponse> postRequest(String urlPath, Map<String, dynamic>? body, {Protocol protocol = Protocol.http, String domain = ""}) async {
    try {
      final response = await post(
        _buildRoute(urlPath, protocol: protocol, domain: domain),
        body: body
      );
      return ApiResponse.fromJson({
        "errored": false,
        "message": "",
        "data": [jsonDecode(response.body)]
      });
    } catch(e) {
      debugPrint(e.toString());
      return ApiResponse.fromJson({"errored": true, "message": e.toString()});
    }
  }

}
