import 'package:client/config/json_constants.dart';

class FavSongModel {
  final String? id;
  final String? songId;
  final String? userId;

  FavSongModel({
    this.id,
    this.songId,
    this.userId,
  });

  factory FavSongModel.fromJson(Map<String, dynamic> json) {
    return FavSongModel(
      id: json[FavSongModelConstants.id] as String?,
      songId: json[FavSongModelConstants.songId] as String?,
      userId: json[FavSongModelConstants.userId] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      FavSongModelConstants.id: id,
      FavSongModelConstants.songId: songId,
      FavSongModelConstants.userId: userId,
    };
  }
}
