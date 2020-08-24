import 'dart:async';

import 'package:SpotifyClone/core/hive_model_converter.dart';
import 'package:SpotifyClone/data/datasources/local_storage.dart';
import 'package:SpotifyClone/data/models/song_details_model.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/streams.dart';

class AudioPlayer extends ChangeNotifier {
  final audioPlayer = AssetsAudioPlayer();
  final LocalStorage localStorage = LocalStorage();
  Duration duration = Duration.zero;
  int get durationInSeconds => duration.inSeconds;
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
    duration = audioPlayer.current.value.audio.duration;
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
    duration = audioPlayer.current.value.audio.duration;
  }

  Future<void> shuffle(Playlist playlist) async {}

  SongDetailsModel getLastPlayed() {
    return localStorage.getLastPlayedSong();
  }

  void seek(int seconds, bool isPlaying, Audio audio) {
    Duration duration = Duration(seconds: seconds);
    if (audio != null) {
      audioPlayer.seek(duration, force: true);
    } else {
      Audio recentAudio =
          audioFromSongDetails(localStorage.getLastPlayedSong());
      audioPlayer.open(recentAudio, seek: duration);
      duration = audioPlayer.current.value.audio.duration;
    }
  }

  Stream getCurrentlyPlaying() {
    return audioPlayer.current;
  }
  Stream isPlaying() {
    return audioPlayer.isPlaying;
  }

  Stream<List> getCurrentStream() {
    Stream currentlyPlayingStream = audioPlayer.current;
    Stream currentPositionStream = audioPlayer.currentPosition;
    Stream playStatus = audioPlayer.isPlaying;
    return Rx.combineLatest3(currentlyPlayingStream, currentPositionStream,
        playStatus, (a, b, c) => [a, b, c]);
  }
}
