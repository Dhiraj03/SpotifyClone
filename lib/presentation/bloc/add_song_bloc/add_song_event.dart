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
