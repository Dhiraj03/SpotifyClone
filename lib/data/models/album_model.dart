import 'package:SpotifyClone/core/constants.dart';
import 'package:SpotifyClone/data/models/album_art_model.dart';
import 'package:SpotifyClone/data/models/song_details_model.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'album_model.g.dart';

@HiveType(typeId: albumModelId)
// ignore: must_be_immutable
class AlbumModel extends Equatable {
  @HiveField(0)
  int albumID;
  @HiveField(1)
  List<SongDetailsModel> songs;
  @HiveField(2)
  AlbumArtModel albumArt;
  @override
  List<Object> get props => [albumID, songs, albumArt];
}
