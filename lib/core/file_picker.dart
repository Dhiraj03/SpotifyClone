import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';

class Picker {
  
  Future<File> pickMusic() async {
    return (await FilePicker.getFile(type: FileType.audio));
  }

  Future<File> pickAlbumArt() async {
    final imageFile = await ImagePicker().getImage(source: ImageSource.gallery);
    return File(imageFile.path);
  }
}
