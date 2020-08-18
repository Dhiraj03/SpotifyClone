import 'dart:async';
import 'dart:io';

import 'package:SpotifyClone/core/file_picker.dart';
import 'package:SpotifyClone/data/models/song_details_model.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

part 'add_song_event.dart';
part 'add_song_state.dart';

class AddSongBloc extends Bloc<AddSongEvent, AddSongState> {
  Audio song;
  SongDetailsModel songDetails;
  Picker picker;
  AddSongBloc() {
    picker = Picker();
  }
  AddSongState get initialState =>
      AddSongInitial(audio: song, songDetails: songDetails);
  @override
  Stream<AddSongState> mapEventToState(
    AddSongEvent event,
  ) async* {
    if (event is PickMusicEvent) {
      File music = await picker.pickMusic();
      song = Audio.file(
        music.path,
      );
      songDetails = SongDetailsModel(song: song);

      yield AddSongInitial(audio: song, songDetails: songDetails);
    } else if (event is PickMusicArt) {
      File file = await picker.pickAlbumArt();
      song = song.copyWith(metas: Metas(image: MetasImage.file(file.path)));
      songDetails.song = song;
      
      print(song.metas.image.path);
      yield AddSongInitial(audio: song, songDetails: songDetails);
    }
  }
}
