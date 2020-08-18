part of 'add_song_bloc.dart';

abstract class AddSongState {
  const AddSongState();
}

class AddSongInitial extends AddSongState {}

class GoBackToDashboard extends AddSongState {}
