import 'package:dio/dio.dart';
import 'package:flutter_rick_and_morty/core/logger/logger.dart';

class LoggingInterceptor extends InterceptorsWrapper {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    Log.i('REQUEST[${options.method}] => ${options.uri}');
    if (options.data != null) {
      Log.i('PAYLOAD: ${options.data}');
    }
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    Log.i('RESPONSE DATA: ${response.data}');

    super.onResponse(response, handler);
  }

  // @override
  // void onError(DioException error, ErrorInterceptorHandler handler) {
  //   Log.e('ERROR: ${error.message}'); // Log the error message
  //   // Perform additional error handling (e.g., show user-friendly message, retry request)

  //   handler.reject(error); // Pass the error forward
  // }
}
