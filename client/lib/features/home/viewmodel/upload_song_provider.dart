import 'dart:io';

import 'package:client/core/utils/picker_utils.dart';
import 'package:flutter/material.dart';

class UploadSongProvider extends ChangeNotifier {
  File? _audio;
  File? _image;
  String? _songName;
  String? _artistName;

  File? get audio => _audio;
  File? get image => _image;
  String? get songName => _songName;
  String? get artistName => _artistName;

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

  void setSongName(String name) {
    Future.microtask(() {
      _songName = name;
      notifyListeners();
    });
  }

  void setArtistName(String name) {
    Future.microtask(() {
      _artistName = name;
      notifyListeners();
    });
  }
}
