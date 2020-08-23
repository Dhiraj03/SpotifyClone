import 'dart:async';

import 'package:SpotifyClone/core/hive_model_converter.dart';
import 'package:SpotifyClone/data/datasources/local_storage.dart';
import 'package:SpotifyClone/data/models/song_details_model.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/cupertino.dart';

class AudioPlayer extends ChangeNotifier {
  final audioPlayer = AssetsAudioPlayer();
  final LocalStorage localStorage = LocalStorage();
  Future<void> playSong(int id) async {
    if (audioPlayer.isPlaying.value != null) {
      audioPlayer.play();
    }

    var tempSongDetails = localStorage.getSong(id);
    var tempSong = audioFromSongDetails(tempSongDetails);
    await localStorage.storeLastPlayedSong(tempSongDetails);
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
    if (audioPlayer.current.hasValue)
      await audioPlayer.playOrPause();
    else
      playRecentSong();
  }

  Future<void> playRecentSong() async {
    if (audioPlayer.current.value != null) await audioPlayer.stop();
    var songDetails = localStorage.getLastPlayedSong();
    var audioSong = audioFromSongDetails(songDetails);
    await audioPlayer.open(audioSong, showNotification: true);
  }

  Future<void> shuffle(Playlist playlist) async {}

  Stream<bool> isPlaying() {
    return audioPlayer.isPlaying;
  }

  bool isPlayingAtThisInstant() {
    return audioPlayer.isPlaying.value;
  }

  Stream<SongDetailsModel> getCurrentlyPlaying() {
    return audioPlayer.current.map((event) {
      return localStorage.getSong(int.parse(event.audio.audio.metas.id));
    });
  }

  SongDetailsModel getLastPlayed() {
    return localStorage.getLastPlayedSong();
  }

  int getDurationOfCurrentSong() {
    if (audioPlayer.current.value == null) {
      return localStorage.durationBox.get('first');
    } else {
      localStorage.durationBox
          .put('first', audioPlayer.current.value.audio.duration.inSeconds);
      return audioPlayer.current.value.audio.duration.inSeconds;
    }
  }

  Stream<int> getCurrentPosition() {
    if (audioPlayer.current.value == null) return Stream.fromIterable([0]);
    return audioPlayer.currentPosition.map((event) => event.inSeconds);
  }

  void seek(int seconds) {
    print('wtff');
    Duration seekDuration = Duration(seconds: seconds);
    if (audioPlayer.isPlaying.value) {
      print('code 1');
      audioPlayer.seek(seekDuration);
      audioPlayer.pause();
    } else if (audioPlayer.isPlaying.value == false) {
      print('code 3');
      audioPlayer.seek(seekDuration);
      audioPlayer.play();
    } else {
      print('code 2');
      audioPlayer.open(
          Audio.file(
              audioFromSongDetails(localStorage.getLastPlayedSong()).path),
          seek: seekDuration);
    }
  }
}
