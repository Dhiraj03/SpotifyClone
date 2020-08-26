part of 'add_playlist_bloc.dart';

abstract class AddPlaylistState extends Equatable {
  const AddPlaylistState();
  
  @override
  List<Object> get props => [];
}

class AddPlaylistInitial extends AddPlaylistState {}
class PopModalSheet extends AddPlaylistState {}