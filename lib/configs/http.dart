import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

Future<T> httpGet<T>({
  required Uri uri,
  required T Function(Map<String, dynamic> data) responseBuilder,
}) async {
  try {
    final response = await http.get(uri);

    switch (response.statusCode) {
      case 200:
        final data = jsonDecode(response.body) as Map<String, dynamic>;
        return responseBuilder(data);

      /// Todo 必要に応じてエラーパターンを増やしていく
      case 503:
        throw Exception('Service Unavailable');
      default:
        throw Exception('Unknown Error');
    }
  } on SocketException catch (e) {
    /// Todo: ロガーを使う
    print('通信エラー $e');
    throw Exception('Network Error');
  }
}