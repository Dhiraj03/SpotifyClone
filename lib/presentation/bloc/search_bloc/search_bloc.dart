import 'dart:async';

import 'package:SpotifyClone/data/datasources/local_storage.dart';
import 'package:SpotifyClone/data/models/playlist_model.dart';
import 'package:SpotifyClone/data/models/song_details_model.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchState get initialState => SearchInitial();
  final LocalStorage localStorage = LocalStorage();
  List<SongDetailsModel> songs;
  List<PlaylistModel> playlists;
  @override
  Stream<SearchState> mapEventToState(
    SearchEvent event,
  ) async* {
    if (event is SearchQueryChanged) {
      songs = localStorage.searchSongs(event.searchQuery);
      playlists = localStorage.searchPlaylists(event.searchQuery);

      yield SearchResult(songs: songs, playlists: playlists);
    }
  }
}
