import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import 'logger.dart';

Future<T> httpGet<T>({
  required Uri uri,
  required T Function(Map<String, dynamic> data) responseBuilder,
}) async {
  try {
    final response = await http.get(uri);

    if (response.statusCode != 200) {
      logger.e(
        'Get response: code = ${response.statusCode}, '
        'reasonPhrase = ${response.reasonPhrase}',
      );
    }

    switch (response.statusCode) {
      case 200:
        final data = jsonDecode(response.body) as Map<String, dynamic>;
        logger.i(data);
        return responseBuilder(data);

      /// Todo 必要に応じてエラーパターンを増やしていく
      case 503:
        throw Exception('Service Unavailable');
      default:
        throw Exception('Unknown Error');
    }
  } on SocketException catch (e) {
    logger.e('通信エラー $e');
    throw Exception('Network Error');
  }
}
