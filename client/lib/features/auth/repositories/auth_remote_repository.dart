import 'dart:convert';
import 'dart:developer';

import 'package:client/config/api_paths.dart';
import 'package:client/config/json_constants.dart';
import 'package:client/core/error/error_handler.dart';
import 'package:client/core/error/failure.dart';
import 'package:client/core/services/api_service.dart';
import 'package:client/features/auth/model/user_model.dart';
import 'package:fpdart/fpdart.dart';

class AuthRemoteRepository {
  Future<Either<AppFailure, UserModel>> signup({
    required UserModel user,
  }) async {
    try {
      final res = await RestApiService.post(ApiPaths.signup, user.toJson());
      return ApiResponseHandler.handleResponse(
        res.statusCode,
        res.body,
        (json) => UserModel.fromJson(json),
      );
    } catch (e) {
      return Left(AppFailure(e.toString()));
    }
  }

  Future<Either<AppFailure, UserModel>> login({
    required String email,
    required String password,
  }) async {
    try {
      final res = await RestApiService.post(
        ApiPaths.login,
        {
          UserModelConstants.email: email,
          UserModelConstants.password: password,
        },
      );
      return ApiResponseHandler.handleResponse(
        res.statusCode,
        res.body,
        (json) => UserModel.fromJson(json).copyWith(
          token: jsonDecode(res.body)['token'],
        ),
        jsonPath: 'user',
      );
    } catch (e) {
      return Left(AppFailure(e.toString()));
    }
  }

  Future<Either<AppFailure, UserModel>> getUserData() async {
    try {
      final res = await RestApiService.get(
        ApiPaths.getUserData,
      );
      return ApiResponseHandler.handleResponse(
        res.statusCode,
        res.body,
        (json) => UserModel.fromJson(json),
      );
    } catch (e) {
      log('error: $e');
      return Left(AppFailure(e.toString()));
    }
  }
}
