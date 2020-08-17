import 'dart:io';

import 'package:file_picker/file_picker.dart';

class MusicPicker {
  Future<File> pickMusic() async {
    return (await FilePicker.getFile());
  }
  
}
