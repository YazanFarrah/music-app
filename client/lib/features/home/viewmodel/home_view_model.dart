import 'package:client/core/models/song_model.dart';
import 'package:client/core/utils/prints_utils.dart';
import 'package:client/core/utils/toast_utils.dart';
import 'package:client/di.dart';
import 'package:client/features/home/repositories/home_local_repository.dart';
import 'package:client/features/home/repositories/home_remote_repository.dart';
import 'package:flutter/material.dart';

class HomeViewModel extends ChangeNotifier {
  final _homeRemoteRepository = getIt<HomeRemoteRepository>();
  final _homeLocalRepository = getIt<HomeLocalRepository>();
  List<SongModel> _songs = [];
  List<SongModel> _savedSongs = [];
  List<SongModel> _favoriteSongs = [];
  bool _isFetchingSongs = false;

  List<SongModel> get songs => _songs;
  List<SongModel> get savedSongs => _savedSongs;
  List<SongModel> get favoriteSongs => _favoriteSongs;
  bool get isFetchingSongs => _isFetchingSongs;

  void fillAllSongs(List<SongModel> songs) {
    Future.microtask(() {
      _songs = songs;
      notifyListeners();
    });
  }

  void addSong(SongModel song) {
    Future.microtask(() {
      _songs.insert(0, song);
      notifyListeners();
    });
  }

  void updateFetchingSongsLoading(bool val) {
    Future.microtask(() {
      _isFetchingSongs = val;
      notifyListeners();
    });
  }

  Future<void> fetchAllSongs(BuildContext context) async {
    final res = await _homeRemoteRepository.getAllSongs();
    updateFetchingSongsLoading(true);
    res.fold((l) {
      updateFetchingSongsLoading(false);
      printError(l);
      ToastUtils.showError(
        context,
        l.message,
      );
    }, (r) {
      updateFetchingSongsLoading(false);
      fillAllSongs(r);
    });
  }

  void saveSongLocally(SongModel song, BuildContext context) {
    _homeLocalRepository.saveSongLocally(song);
    _savedSongs.add(song);
    ToastUtils.showSuccess(context, "Song was saved successfully");
    notifyListeners();
  }

  List<SongModel> getSavedSongs() {
    _savedSongs = _homeLocalRepository.loadSongs();
    return _savedSongs;
  }

  void removeSavedSong(SongModel song, BuildContext context) {
    final res = _homeLocalRepository.removedSavedSongSuccessfully(song);
    if (res) {
      _savedSongs.removeWhere((e) => e.id == song.id);
      ToastUtils.showSuccess(context, "Song was removed successfully");
      notifyListeners();
    }
  }

  bool isSongSaved(SongModel song) {
    return _savedSongs.any((savedSong) => savedSong.id == song.id) == true;
  }

  Future<bool?> favUnfavSong({
    required BuildContext context,
    required SongModel song,
  }) async {
    final res = await _homeRemoteRepository.favoriteSong(song.id!);

    return res.fold(
      (l) {
        printError(l.message);
        return false;
      },
      (r) {
        if (r) {
          if (!_favoriteSongs.any((favSong) => favSong.id == song.id)) {
            _favoriteSongs.add(song);
            notifyListeners();
          }
          return true;
        } else {
          _favoriteSongs.removeWhere((favSong) => favSong.id == song.id);
          notifyListeners();
          return false;
        }
      },
    );
  }

  Future<void> getAllFavSongs({
    required BuildContext context,
  }) async {
    final res = await _homeRemoteRepository.getAllfavoriteSongs();

    return res.fold(
      (l) {
        return;
      },
      (r) {
        _favoriteSongs = r;
        notifyListeners();
      },
    );
  }

  bool isSongFav(SongModel song) {
    return _favoriteSongs.any((e) => e.id == song.id);
  }
}
