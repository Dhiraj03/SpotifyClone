part of 'add_playlist_bloc.dart';

abstract class AddPlaylistEvent extends Equatable {
  const AddPlaylistEvent();

  @override
  List<Object> get props => [];
}

class PickAlbumArt extends AddPlaylistEvent {
  @override
  List<Object> get props => [];
}

class AddPlaylistToLibrary extends AddPlaylistEvent {
  final String name;
  final List<String> genres;
  final SongDetailsModel song;
  AddPlaylistToLibrary(
      {@required this.name,
      @required this.genres,
      @required this.song});
  @override
  List<Object> get props => [name,genres, song];
}
