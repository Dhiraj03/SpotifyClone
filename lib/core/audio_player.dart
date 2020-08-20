import 'package:SpotifyClone/core/hive_model_converter.dart';
import 'package:SpotifyClone/data/datasources/local_storage.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/cupertino.dart';

class AudioPlayer extends ChangeNotifier {
  final audioPlayer = AssetsAudioPlayer();
  final LocalStorage localStorage = LocalStorage();
  Future<void> playSong(int id) async {
    var tempSong = audioFromSongDetails(localStorage.getSong(id));
    if (await audioPlayer.isPlaying.first) audioPlayer.stop();
    audioPlayer.open(tempSong, showNotification: true);
  }
}
