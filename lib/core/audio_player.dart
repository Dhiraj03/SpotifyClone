import 'package:SpotifyClone/core/hive_model_converter.dart';
import 'package:SpotifyClone/data/datasources/local_storage.dart';
import 'package:SpotifyClone/data/models/song_details_model.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/cupertino.dart';

class AudioPlayer extends ChangeNotifier {
  final audioPlayer = AssetsAudioPlayer();
  final LocalStorage localStorage = LocalStorage();
  Future<void> playSong(int id) async {
    var tempSongDetails = localStorage.getSong(id);
    await localStorage.storeLastPlayedSong(tempSongDetails);
    var tempSong = audioFromSongDetails(tempSongDetails);
    audioPlayer.stop();
    audioPlayer.open(tempSong,
        showNotification: true, notificationSettings: NotificationSettings());
  }

  Future<void> stop() async {
    await audioPlayer.stop();
  }

  Future<void> loop() async {
    await audioPlayer.toggleLoop();
  }

  Future<void> playOrPause() async {
     
      await audioPlayer.playOrPause();
  }

   Future<void> playRecentSong() async{
    var songDetails = localStorage.getLastPlayedSong();
    var audioSong = audioFromSongDetails(songDetails);
    await audioPlayer.open(audioSong, showNotification: true);
   }

  Future<void> shuffle(Playlist playlist) async {}

  Stream<bool> isPlaying() {
    return audioPlayer.isPlaying;
  }

  Stream<Playing> getCurrentlyPlaying() {
    return audioPlayer.current;
  }

  SongDetailsModel getLastPlayed() {
    return localStorage.getLastPlayedSong();
  }
}
