import 'dart:async';
import 'dart:io';

import 'package:SpotifyClone/core/file_picker.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'add_song_event.dart';
part 'add_song_state.dart';

class AddSongBloc extends Bloc<AddSongEvent, AddSongState> {
  Audio song;
  MusicPicker musicPicker;
  AddSongBloc() {
    musicPicker = MusicPicker();
  }
  AddSongState get initialState => AddSongInitial();
  @override
  Stream<AddSongState> mapEventToState(
    AddSongEvent event,
  ) async* {
    if (event is PickMusicEvent) {
      File music = await musicPicker.pickMusic();
      song = Audio.file(music.path);
      print('path' +  song.path);
      yield AddSongInitial();
    }
  }
}
