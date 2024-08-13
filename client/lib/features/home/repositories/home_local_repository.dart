import 'package:client/core/models/song_model.dart';
import 'package:hive/hive.dart';

class HomeLocalRepository {
  final Box box = Hive.box();

  void saveSongLocally(SongModel song) {
    if (!box.containsKey(song.id!)) {
      box.put(song.id!, song.toJson());
    }
  }

  List<SongModel> loadSongs() {
    List<SongModel> songs = [];

    for (final key in box.keys) {
      songs.add(SongModel.fromJson(box.get(key)));
    }
    return songs;
  }

  bool removedSavedSongSuccessfully(SongModel song) {
    if (box.containsKey(song.id!)) {
      final res = box.delete(song.id!);
      return res;
    }
    return false;
  }
}
