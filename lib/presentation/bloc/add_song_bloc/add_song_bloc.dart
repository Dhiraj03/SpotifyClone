import 'dart:async';
import 'dart:io';

import 'package:SpotifyClone/core/file_picker.dart';
import 'package:SpotifyClone/data/datasources/local_storage.dart';
import 'package:SpotifyClone/data/models/album_art_model.dart';
import 'package:SpotifyClone/data/models/song_details_model.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:palette_generator/palette_generator.dart';

part 'add_song_event.dart';
part 'add_song_state.dart';

class AddSongBloc extends Bloc<AddSongEvent, AddSongState> {
  SongDetailsModel songDetails = SongDetailsModel();
  final LocalStorage localStorage = LocalStorage();
  final Picker picker = Picker();

  AddSongState get initialState => AddSongInitial();
  @override
  Stream<AddSongState> mapEventToState(
    AddSongEvent event,
  ) async* {
    if (event is PickMusicEvent) {
      File pickedMusic = await picker.pickMusic();
      Audio pickedAudio = Audio.file(
        pickedMusic.path,
      );
      songDetails.path = pickedAudio.path;
      yield AddSongInitial();
    } else if (event is PickMusicArt) {
      File imageFile = await picker.pickAlbumArt();
      songDetails.imagePath = imageFile.path;
      yield AddSongInitial();
    } else if (event is AddMusicToLibrary) {
      final length = localStorage.getSongsLength();
      var colors = await PaletteGenerator.fromImageProvider(
          FileImage(File(songDetails.imagePath)));
      songDetails.colors = colors.dominantColor.color.toString();
      songDetails.songID = length;
      songDetails.artists = event.artist;
      songDetails.album = event.album;
      songDetails.title = event.track;
      songDetails.genres = event.genres;
      await localStorage.addSong(songDetails);
      yield GoBackToDashboard();
    }
  }
}
