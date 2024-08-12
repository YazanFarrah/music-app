import 'package:client/config/json_constants.dart';

class SongModel {
  final String? id;
  final String? songName;
  final String? artistName;
  final String? thumbnailUrl;
  final String? songUrl;
  final String? hexCode;

  SongModel({
    this.id,
    this.songName,
    this.artistName,
    this.thumbnailUrl,
    this.songUrl,
    this.hexCode,
  });

  factory SongModel.fromJson(Map<String, dynamic> json) {
    return SongModel(
      id: json[SongModelConstants.id] as String?,
      songName: json[SongModelConstants.songName] as String?,
      artistName: json[SongModelConstants.artistName] as String?,
      thumbnailUrl: json[SongModelConstants.thumbnailUrl] as String?,
      songUrl: json[SongModelConstants.songUrl] as String?,
      hexCode: json[SongModelConstants.hexCode] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      SongModelConstants.id: id,
      SongModelConstants.songName: songName,
      SongModelConstants.artistName: artistName,
      SongModelConstants.thumbnailUrl: thumbnailUrl,
      SongModelConstants.songUrl: songUrl,
      SongModelConstants.hexCode: hexCode,
    };
  }

  @override
  String toString() {
    return 'SongModel(id: $id, songName: $songName, artistName: $artistName, thumbnailUrl: $thumbnailUrl, songUrl: $songUrl, hexCode: $hexCode)';
  }
}