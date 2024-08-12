import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:client/config/asset_paths.dart';
import 'package:client/core/utils/color_utils.dart';
import 'package:client/core/utils/picker_utils.dart';
import 'package:client/core/utils/prints_utils.dart';
import 'package:client/core/utils/toast_utils.dart';
import 'package:client/di.dart';
import 'package:client/features/home/repositories/home_repository.dart';
import 'package:flutter/material.dart';

class UploadSongViewModel extends ChangeNotifier {
  final _homeRemoteRepository = getIt<HomeRemoteRepository>();
  final _audioPlayer = AudioPlayer();
  File? _audio;
  File? _image;
  String? _hexCode;
  bool _isLoading = false;

  File? get audio => _audio;
  File? get image => _image;
  String? get hexCode => _hexCode;
  bool get isLoading => _isLoading;

  void selectAudio() async {
    final pickedAudio = await PickerUtils.pickAudio();

    if (pickedAudio != null) {
      Future.microtask(() {
        _audio = pickedAudio;
        notifyListeners();
      });
    }
  }

  void selectImage() async {
    final pickedImage = await PickerUtils.pickImage();
    if (pickedImage != null) {
      Future.microtask(() {
        _image = pickedImage;
        notifyListeners();
      });
    }
  }

  void setHexCode(String code) {
    Future.microtask(() {
      _hexCode = code;
      notifyListeners();
    });
  }

  void updateLoading(bool val) {
    Future.microtask(() {
      _isLoading = val;
      notifyListeners();
    });
  }

  Future<void> uploadSong({
    required BuildContext context,
    required String artistName,
    required String songName,
  }) async {
    updateLoading(true);
    final res = await _homeRemoteRepository.uploadSong(
      songPath: _audio!.path,
      imagePath: _image!.path,
      artistName: artistName,
      songName: songName,
      hexCode: _hexCode ?? generateRandomHexColor(),
    );
    res.fold((l) {
      updateLoading(false);
      ToastUtils.showError(context, l.message);
      printError(l);
    }, (r) {
      updateLoading(false);
      _audioPlayer.play(AssetSource(AssetPaths.successAudio)).then((_) {
        _audioPlayer.dispose();
      });
      ToastUtils.showSuccess(context, "Song was added successfully!");
      clear();
    });
  }

  void clear() {
    _audio = null;
    _image = null;
    _hexCode = null;
    notifyListeners();
  }
}
