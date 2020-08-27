part of 'search_bloc.dart';

abstract class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object> get props => [];
}

class SearchInitial extends SearchState {}

class SearchResult extends SearchState {
  final List<SongDetailsModel> songs;
  final List<PlaylistModel> playlists;
  SearchResult({@required this.songs, @required this.playlists});
  List<Object> get props => [songs, playlists];
}
