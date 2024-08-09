import 'dart:convert';
import 'package:client/core/error/failure.dart';
import 'package:fpdart/fpdart.dart';

class ApiResponseHandler {
  static Either<AppFailure, T> handleResponse<T>(int statusCode,
      String responseBody, T Function(Map<String, dynamic>) fromJson,
      {String? jsonPath}) {
    final Map<String, dynamic> resBodyMap =
        jsonDecode(responseBody) as Map<String, dynamic>;

    if (statusCode >= 200 && statusCode < 300) {
      final data = jsonPath != null ? resBodyMap[jsonPath] : resBodyMap;
      return Right(fromJson(data));
    } else if (statusCode >= 400 && statusCode < 500) {
      final errorMessage = resBodyMap['detail'] ?? 'Validation error occurred';
      return Left(ValidationFailure(errorMessage));
    } else if (statusCode >= 500 && statusCode < 600) {
      final errorMessage = resBodyMap['detail'] ?? 'Server error occurred';
      return Left(ServerFailure(errorMessage));
    } else {
      final errorMessage = resBodyMap['detail'] ?? 'An unknown error occurred';
      return Left(UnknownFailure(errorMessage));
    }
  }
}
