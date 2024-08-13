import 'dart:io';

class ApiPaths {
  static String baseUrl =
      Platform.isAndroid ? 'http://10.0.2.2:8000/' : 'http://127.0.0.1:8000/';

  static const String signup = 'auth/signup';
  static const String login = 'auth/login';
  static const String getUserData = 'auth/';


  // Song:
  static const String uploadSong = 'song/upload';
  static const String getAllSongs = 'song/list';
  static const String favoriteSong = 'song/favorite';
  static const String getAllFavoriteSongs = 'song/favorites-list';

}
