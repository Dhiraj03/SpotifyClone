import 'dart:async';
import 'dart:io';

import 'package:SpotifyClone/core/file_picker.dart';
import 'package:SpotifyClone/data/datasources/local_storage.dart';
import 'package:SpotifyClone/data/models/playlist_model.dart';
import 'package:SpotifyClone/data/models/song_details_model.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'add_playlist_event.dart';
part 'add_playlist_state.dart';

class AddPlaylistBloc extends Bloc<AddPlaylistEvent, AddPlaylistState> {
  AddPlaylistState get initialState => AddPlaylistInitial();
  final LocalStorage localStorage = LocalStorage();
  final Picker picker = Picker();
  PlaylistModel playlist = PlaylistModel();
  @override
  Stream<AddPlaylistState> mapEventToState(
    AddPlaylistEvent event,
  ) async* {
    if (event is PickAlbumArt) {
      File imageFile = await picker.pickAlbumArt();
      playlist.imagePath = imageFile.path;
      yield AddPlaylistInitial();
    } else if (event is AddPlaylistToLibrary) {
      final length = localStorage.getPlaylistLength();
      playlist.albumID = length;
      playlist.genres = event.genres;
      playlist.isAlbum = false;
      playlist.name = event.name;
      playlist.songs = [];
      playlist.songs.add(event.song);
      await localStorage.addPlaylist(playlist);
      yield PopModalSheet();
    } else if (event is CreatePlaylistEvent) {
      final length = localStorage.getPlaylistLength();
      playlist.albumID = length;
      playlist.genres = event.genres;
      playlist.isAlbum = false;
      playlist.name = event.name;
      playlist.songs = [];
      await localStorage.addPlaylist(playlist);
      yield PopModalSheet();
    }
  }
}
