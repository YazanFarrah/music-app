import 'package:client/config/api_paths.dart';
import 'package:client/core/error/error_handler.dart';

import 'package:client/core/error/failure.dart';
import 'package:client/core/models/song_model.dart';
import 'package:client/core/services/api_service.dart';
import 'package:client/di.dart';
import 'package:client/features/auth/repositories/auth_local_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart' as http;

class HomeRemoteRepository {
  final token = getIt<AuthLocalRepository>().getToken;

  Future<Either<AppFailure, String>> uploadSong({
    required String songPath,
    required String imagePath,
    required String songName,
    required String artistName,
    required String hexCode,
  }) async {
    try {
      final request = http.MultipartRequest(
          'POST', Uri.parse("${ApiPaths.baseUrl}${ApiPaths.uploadSong}"));
      request
        ..files.addAll([
          await http.MultipartFile.fromPath(
            "song",
            songPath,
          ),
          await http.MultipartFile.fromPath(
            "thumbnail",
            imagePath,
          ),
        ])
        ..fields.addAll({
          'artist_name': artistName,
          'song_name': songName,
          'hex_code': hexCode,
        })
        ..headers.addAll({'x-auth-token': token ?? ""});
      final res = await request.send();
      final responseString = await res.stream.bytesToString();

      if (res.statusCode != 201) {
        return left(
          AppFailure(
            responseString,
          ),
        );
      }

      return right(responseString);
    } catch (e) {
      return left(AppFailure(e.toString()));
    }
  }

  Future<Either<AppFailure, List<SongModel>>> getAllSongs() async {
    try {
      final res = await RestApiService.get(ApiPaths.getAllSongs);
      return ApiResponseHandler.handleListResponse<SongModel>(
        res,
        (json) => SongModel.fromJson(json),
      );
    } catch (e) {
      return left(AppFailure(e.toString()));
    }
  }
}
