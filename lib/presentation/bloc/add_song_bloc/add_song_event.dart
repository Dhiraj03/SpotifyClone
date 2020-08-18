part of 'add_song_bloc.dart';

abstract class AddSongEvent extends Equatable {
  const AddSongEvent();

  @override
  List<Object> get props => [];
}

class PickMusicEvent extends AddSongEvent {
  @override
  List<Object> get props => [];
}

class PickMusicArt extends AddSongEvent {
  @override
  List<Object> get props => [];
}

class AddMusicToLibrary extends AddSongEvent {
  final String artist;
  final String album;
  final String track;
  final List<String> genres;
  AddMusicToLibrary({this.album, this.artist, this.genres, this.track});
  @override
  List<Object> get props => [album, artist, genres, track];
}
