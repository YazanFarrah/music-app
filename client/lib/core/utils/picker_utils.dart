import 'dart:io';

import 'package:client/core/utils/prints_utils.dart';
import 'package:file_picker/file_picker.dart';

class PickerUtils {
  static Future<File?> pickAudio() async {
    try {
      final filePickerRes = await FilePicker.platform.pickFiles(
        type: FileType.audio,
      );
      if (filePickerRes != null) {
        return File(filePickerRes.files.first.xFile.path);
      }
      return null;
    } catch (e) {
      printError(e);
      return null;
    }
  }
   static Future<File?> pickImage() async {
    try {
      final filePickerRes = await FilePicker.platform.pickFiles(
        type: FileType.image,
      );
      if (filePickerRes != null) {
        return File(filePickerRes.files.first.xFile.path);
      }
      return null;
    } catch (e) {
      printError(e);
      return null;
    }
  }
}
