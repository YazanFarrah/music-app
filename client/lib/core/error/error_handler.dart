import 'dart:convert';
import 'package:client/core/error/failure.dart';
import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart';

class ApiResponseHandler {
  // Handle a response for a list of items
  static Either<AppFailure, List<T>> handleListResponse<T>(
      Response response, T Function(Map<String, dynamic>) fromJson,
      {String? jsonPath}) {
    final int statusCode = response.statusCode;
    final String responseBody = response.body;

    final dynamic resBody = jsonDecode(responseBody);

    if (statusCode >= 200 && statusCode < 300) {
      final data = jsonPath != null && resBody is Map<String, dynamic>
          ? resBody[jsonPath]
          : resBody;

      if (data is List) {
        final list =
            data.map((item) => fromJson(item as Map<String, dynamic>)).toList();
        return Right(list);
      } else {
        return Left(
          ParsingFailure('Expected a list but received something else'),
        );
      }
    } else if (statusCode >= 400 && statusCode < 500) {
      final errorMessage =
          (resBody is Map<String, dynamic> && resBody['detail'] != null)
              ? resBody['detail']
              : 'Validation error occurred';
      return Left(ValidationFailure(errorMessage));
    } else if (statusCode >= 500 && statusCode < 600) {
      final errorMessage =
          (resBody is Map<String, dynamic> && resBody['detail'] != null)
              ? resBody['detail']
              : 'Server error occurred';
      return Left(ServerFailure(errorMessage));
    } else {
      final errorMessage =
          (resBody is Map<String, dynamic> && resBody['detail'] != null)
              ? resBody['detail']
              : 'An unknown error occurred';
      return Left(UnknownFailure(errorMessage));
    }
  }

  // Handle a response for a single item
  static Either<AppFailure, T> handleSingleResponse<T>(
      Response response, T Function(Map<String, dynamic>) fromJson,
      {String? jsonPath}) {
    final int statusCode = response.statusCode;
    final String responseBody = response.body;

    final dynamic resBody = jsonDecode(responseBody);

    if (statusCode >= 200 && statusCode < 300) {
      final data = jsonPath != null && resBody is Map<String, dynamic>
          ? resBody[jsonPath]
          : resBody;

      if (data is Map<String, dynamic>) {
        final item = fromJson(data);
        return Right(item);
      } else {
        return Left(
          ParsingFailure(
              'Expected a Map<String, dynamic> but received something else or null'),
        );
      }
    } else if (statusCode >= 400 && statusCode < 500) {
      final errorMessage =
          (resBody is Map<String, dynamic> && resBody['detail'] != null)
              ? resBody['detail']
              : 'Validation error occurred';
      return Left(ValidationFailure(errorMessage));
    } else if (statusCode >= 500 && statusCode < 600) {
      final errorMessage =
          (resBody is Map<String, dynamic> && resBody['detail'] != null)
              ? resBody['detail']
              : 'Server error occurred';
      return Left(ServerFailure(errorMessage));
    } else {
      final errorMessage =
          (resBody is Map<String, dynamic> && resBody['detail'] != null)
              ? resBody['detail']
              : 'An unknown error occurred';
      return Left(UnknownFailure(errorMessage));
    }
  }
}
