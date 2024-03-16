import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rick_and_morty/core/constants/string_constants.dart';
import 'package:flutter_rick_and_morty/core/utils/dio_interceptors.dart';
import 'package:flutter_rick_and_morty/core/utils/error_utils/api_error_handler.dart';
import 'package:flutter_rick_and_morty/core/widgets/loading_indicator.dart';

class ApiUtils {
  final dio = Dio()
    ..options.baseUrl = UrlConstants.apiBaseUrl
    ..options.headers = {HttpHeaders.contentTypeHeader: HttpHeaders.applicationHeaderString}
    ..options.connectTimeout =
        const Duration(milliseconds: 50000) // Timeout duration set to 5 seconds
    ..options.receiveTimeout =
        const Duration(milliseconds: 50000) // Timeout duration set to 5 seconds
    ..options.responseType = ResponseType.json
    ..interceptors.add(LoggingInterceptor());

  Future<Response> handleResponse(
      Future<Response> Function() requestFunction, BuildContext context) async {
    try {
      loadingIndicator.show(context);
      Response response = await requestFunction();

      loadingIndicator.hide();
      if (response.statusCode == 200) {
        return response; // Return successful response
      }
    } on DioException catch (e) {
      loadingIndicator.hide();

      switch (e.type) {
        case DioExceptionType.connectionError:
          throw NetworkError("Internet connection error");
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.receiveTimeout:
          throw NetworkError("Network timeout occurred");

        case DioExceptionType.cancel:
          // Handle cancellation errors specifically
          break;
        case DioExceptionType.badResponse:
          throw ServerError(e.response?.statusCode ?? 0,
              e.response?.data["message"] ?? "Server error on a bad response");
        default:
          throw UnexpectedErrorException("Unknown error -> TYPE: ${e.type} MESSAGE: ${e.message}");
      }
    } finally {
      loadingIndicator.hide();
    }

    // If no specific return or throw happens above, throw an exception
    throw UnexpectedErrorException("Unknown error");
  }

  Future<Response> handleBackgroundResponse(
      Future<Response> Function() requestFunction, BuildContext context) async {
    try {
      Response response = await requestFunction();

      if (response.statusCode == 200) {
        return response; // Return successful response
      }
    } on DioException catch (e) {
      loadingIndicator.hide();

      switch (e.type) {
        case DioExceptionType.connectionError:
          throw NetworkError("Internet connection error");
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.receiveTimeout:
          throw NetworkError("Network timeout occurred");

        case DioExceptionType.cancel:
          // Handle cancellation errors specifically
          break;
        case DioExceptionType.badResponse:
          throw ServerError(e.response?.statusCode ?? 0,
              e.response?.data["message"] ?? "Server error on a bad response");
        default:
          throw UnexpectedErrorException("Unknown error -> TYPE: ${e.type} MESSAGE: ${e.message}");
      }
    } finally {
      loadingIndicator.hide();
    }

    // If no specific return or throw happens above, throw an exception
    throw UnexpectedErrorException("Unknown error");
  }

  Future<Response> sendLoginOtp(Map bodyData, String url, BuildContext context) async {
    return handleResponse(() async {
      return dio.post(url, data: bodyData);
    }, context);
  }

  Future<Response> httpPostCall(Map bodyData, String url, BuildContext context) async {
    return handleResponse(() async {
      return await dio.post(
        url,
        data: bodyData,
      );
    }, context);
  }

  Future<Response> httpGetCall(String url, BuildContext context) async {
    return handleResponse(() async {
      return await dio.get(url);
    }, context);
  }

  Future<Response> httpPutCall(Map bodyData, String url, BuildContext context) async {
    return handleResponse(() async {
      return await dio.put(
        url,
        data: bodyData,
      );
    }, context);
  }

  Future<Response> httpPostBackgroundCall(Map bodyData, String url, BuildContext context) async {
    return handleBackgroundResponse(() async {
      return await dio.post(
        url,
        data: bodyData,
      );
    }, context);
  }

  Future<Response> httpGetBackgroundCall(String url, BuildContext context) async {
    return handleBackgroundResponse(() async {
      return await dio.get(url);
    }, context);
  }
}
