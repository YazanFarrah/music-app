import 'package:just_audio/just_audio.dart';
import 'package:client/core/models/song_model.dart';
import 'package:flutter/material.dart';

class CurrentSongProvider extends ChangeNotifier {
  AudioPlayer? _audioPlayer;
  bool _isPlaying = false;
  SongModel? _currentSong;

  SongModel? get currentSong => _currentSong;
  AudioPlayer? get audioPlayer => _audioPlayer;
  bool get isPlaying => _isPlaying;

  void updateSong(SongModel song) async {
    if (song.id == _currentSong?.id) {
      return;
    } else {
      _currentSong = null;
      _audioPlayer?.dispose();
      notifyListeners();
    }

    if (song.songUrl != null) {
      _audioPlayer = AudioPlayer();

      final audioSource = AudioSource.uri(
        Uri.parse(song.songUrl!),
      );
      _currentSong = song;
      _isPlaying = true;
      notifyListeners();
      await _audioPlayer!.setAudioSource(audioSource);

      _audioPlayer!.playerStateStream.listen((state) {
        if (state.processingState == ProcessingState.completed) {
          _audioPlayer!.seek(Duration.zero);
          _audioPlayer!.pause();
          _isPlaying = false;
          notifyListeners();
        }
      });
      _audioPlayer!.play();
    }
  }

  void playPause() {
    if (_isPlaying) {
      _audioPlayer?.pause();
    } else {
      _audioPlayer?.play();
    }

    _isPlaying = !_isPlaying;
    notifyListeners();
  }

  void seek(double val) {
    if (_audioPlayer != null) {
      _audioPlayer!.seek(
        Duration(
          milliseconds: (val * _audioPlayer!.duration!.inMilliseconds).toInt(),
        ),
      );
    }
  }
}
