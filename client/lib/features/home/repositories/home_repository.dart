import 'dart:developer';

import 'package:client/config/api_paths.dart';
import 'package:client/di.dart';
import 'package:client/features/auth/repositories/auth_local_repository.dart';
import 'package:http/http.dart' as http;

class HomeRepository {
  Future<void> uploadSong(String songPath, String imagePath) async {
    final token = getIt<AuthLocalRepository>().getToken;
    final request = http.MultipartRequest(
        'POST', Uri.parse("${ApiPaths.baseUrl}song/${ApiPaths.uploadSong}"));
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
        'artist': 'Elyana',
        'song_name': 'tamalli maak',
        'hex_code': 'FFFFFF',
      })
      ..headers.addAll({'x-auth-token': token ?? ""});
    final res = await request.send();
    log(res.toString());
  }
}
