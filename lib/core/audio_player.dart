import 'dart:async';
import 'dart:io';

import 'package:SpotifyClone/core/hive_model_converter.dart';
import 'package:SpotifyClone/data/datasources/local_storage.dart';
import 'package:SpotifyClone/data/models/playlist_model.dart';
import 'package:SpotifyClone/data/models/song_details_model.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/streams.dart';

class AudioPlayer extends ChangeNotifier {
  final audioPlayer = AssetsAudioPlayer();
  final LocalStorage localStorage = LocalStorage();
  Duration duration = Duration.zero;
  int get durationInSeconds => duration.inSeconds;

  Future<void> playSong(int id) async {
    var tempSongDetails = localStorage.getSong(id);
    var tempSong = audioFromSongDetails(tempSongDetails);
    await localStorage.storeLastPlayedSong(tempSongDetails);
    audioPlayer.stop();
    await audioPlayer.open(tempSong,
        showNotification: true, notificationSettings: NotificationSettings());
    duration = audioPlayer.current.value.audio.duration;
  }

  Future<void> stop() async {
    await audioPlayer.stop();
  }

  Future<void> toggleLoop() async {
    await audioPlayer.toggleLoop();
  }

  Future<void> shufflePlaylist() async {
    await audioPlayer.toggleShuffle();
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

  Future<void> likeSong(int songID) async {
    await localStorage.likeSong(songID);
  }

  Future<void> deleteSong(int songID) async {
    await localStorage.deleteSong(songID);
  }

  SongDetailsModel getLastPlayed() {
    return localStorage.getLastPlayedSong();
  }

  void seek(int seconds, bool isPlaying, Audio audio) async {
    Duration duration = Duration(seconds: seconds);
    if (audio != null) {
      print('sliding');
      audioPlayer.seek(duration);
    } else {
      Audio recentAudio =
          audioFromSongDetails(localStorage.getLastPlayedSong());
      await audioPlayer.open(recentAudio, seek: duration);
    }
  }

  Stream getCurrentlyPlaying() {
    return audioPlayer.current;
  }

  Stream isPlaying() {
    return audioPlayer.isPlaying;
  }

  Future<void> loop() async {
    return await audioPlayer.setLoopMode(LoopMode.single);
  }

  Stream<List> getCurrentStream() {
    Stream currentlyPlayingStream =
        audioPlayer.current; //Gets the currently playing audio file
    Stream currentPositionStream = audioPlayer.currentPosition;
    Stream playStatus = audioPlayer.isPlaying;
    Stream loopMode = audioPlayer.loopMode;
    Stream shuffleMode = audioPlayer.isShuffling;
    return Rx.combineLatest5(currentlyPlayingStream, currentPositionStream,
        playStatus, loopMode, shuffleMode, (a, b, c, d, e) => [a, b, c, d, e]);
  }

  void playlistOnShuffle(PlaylistModel playlist) async {
    audioPlayer.stop();
    await audioPlayer.open(playlistFromSongDetails(playlist),
        showNotification: true);
  }

  void playNext() {
    audioPlayer.next(stopIfLast: false, keepLoopMode: false);
  }

  void playPrevious() {
    audioPlayer.previous(keepLoopMode: false);
  }
}
