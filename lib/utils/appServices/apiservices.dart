import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:utility_app_flutter/utils/Constants/api_url.dart';
import 'package:utility_app_flutter/widgets/snackbar.dart';

class Apiservices {
  late Dio _dio;

  Apiservices() {
    BaseOptions options = BaseOptions(
      baseUrl: ApiUrl.baseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      sendTimeout: const Duration(seconds: 10),
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
      },
    );

    _dio = Dio(options);

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          debugPrint("➡️ ${options.method} | ${options.uri}");

          return handler.next(options);
        },
        onResponse: (response, handler) {
          debugPrint("✅ Response: ${response.statusCode} | ${response.data}");
          return handler.next(response);
        },
        onError: (DioException e, handler) {
          debugPrint("❌ Error: ${e.message}");

          return handler.next(e);
        },
      ),
    );
  }

  // Get Method
  Future<Response> getRequest(
    String endpoint, {
    Map<String, dynamic>? queryParams,
  }) async {
    try {
      return await _dio.get(endpoint, queryParameters: queryParams);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// 🔹 POST request
  Future<Response> postRequest(
    String endpoint, {
    dynamic data,
    Map<String, dynamic>? queryParams,
  }) async { 
    try {
      return await _dio.post(
        endpoint,
        data: data,
        queryParameters: queryParams,
      );
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// 🔹 PUT request
  Future<Response> putRequest(String endpoint, {dynamic data}) async {
    try {
      return await _dio.put(endpoint, data: data);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// 🔹 DELETE request
  Future<Response> deleteRequest(String endpoint, {dynamic data}) async {
    try {
      return await _dio.delete(endpoint, data: data);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// 🔹 Multipart File Upload (Images / Docs)
  Future<Response> uploadMultipleFiles(
    String endpoint, {
    required List<File> files,
    String fieldName = "files",
    Map<String, dynamic>? data,
  }) async {
    try {
      List<MultipartFile> multipartFiles = [];

      for (var file in files) {
        String fileName = file.path.split("/").last;
        multipartFiles.add(
          await MultipartFile.fromFile(file.path, filename: fileName),
        );
      }

      FormData formData = FormData.fromMap({
        fieldName: multipartFiles, // multiple files under one field name
        ...?data, // extra body fields
      });

      return await _dio.post(
        endpoint,
        data: formData,
        options: Options(contentType: "multipart/form-data"),
      );
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// 🔹 Centralized Error Handling
  String _handleError(DioException error) {
    if (error.type == DioExceptionType.connectionTimeout) {
      showSnackBar(
        title: "Error",
        message: "Connection Timeout. Please try again.",
      );
      return "Connection Timeout. Please try again.";
    } else if (error.type == DioExceptionType.receiveTimeout) {
      showSnackBar(title: "Error", message: "Server took too long to respond.");
      return "Server took too long to respond.";
    } else if (error.type == DioExceptionType.sendTimeout) {
      showSnackBar(title: "Error", message: "Request timed out.");
      return "Request timed out.";
    } else if (error.type == DioExceptionType.badResponse) {
      showSnackBar(
        title: "Error",
        message: "Server error: ${error.response?.statusCode}",
      );
      return "Server error: ${error.response?.statusCode}";
    } else if (error.type == DioExceptionType.cancel) {
      showSnackBar(title: "Error", message: "Request was cancelled.");
      return "Request was cancelled.";
    } else {
      showSnackBar(
        title: "Error",
        message: "Unexpected error occurred: ${error.message}",
      );
      return "Unexpected error occurred: ${error.message}";
    }
  }
}
