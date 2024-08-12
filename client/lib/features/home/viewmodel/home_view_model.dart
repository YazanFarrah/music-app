import 'package:client/core/models/song_model.dart';
import 'package:client/core/utils/prints_utils.dart';
import 'package:client/core/utils/toast_utils.dart';
import 'package:client/di.dart';
import 'package:client/features/home/repositories/home_repository.dart';
import 'package:flutter/material.dart';

class HomeViewModel extends ChangeNotifier {
  final _homeRemoteRepository = getIt<HomeRemoteRepository>();

  List<SongModel> _songs = [];
  bool _isFetchingSongs = false;

  List<SongModel> get songs => _songs;
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
}
