part of 'add_playlist_bloc.dart';

abstract class AddPlaylistState{
  const AddPlaylistState();
}

class AddPlaylistInitial extends AddPlaylistState {}
class PopModalSheet extends AddPlaylistState {}