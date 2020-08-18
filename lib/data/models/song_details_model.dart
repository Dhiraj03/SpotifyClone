import 'package:SpotifyClone/core/constants.dart';
import 'package:SpotifyClone/data/models/album_art_model.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'song_details_model.g.dart';

@HiveType(typeId: songDetailModelId)
class SongDetailsModel extends Equatable {
  @HiveField(0)
  Audio song;
  @HiveField(1)
  AlbumArtModel albumArt;
  @HiveField(2)
  List<String> genres;
  @HiveField(3)
  int songID;
  SongDetailsModel({this.albumArt, this.genres, this.song, this.songID});
  List<Object> get props => <dynamic>[song, albumArt, genres, songID];
}
