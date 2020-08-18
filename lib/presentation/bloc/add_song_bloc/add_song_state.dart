part of 'add_song_bloc.dart';

abstract class AddSongState {
  const AddSongState();
}

class AddSongInitial extends AddSongState {
  Audio audio;
  SongDetailsModel songDetails;
  AddSongInitial({this.audio, this.songDetails});
  @override
  List<Object> get props => [songDetails, audio];
}
