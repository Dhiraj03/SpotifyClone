import 'dart:io';

import 'package:SpotifyClone/core/constants.dart';
import 'package:SpotifyClone/data/models/album_art_model.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'song_details_model.g.dart';

@HiveType(typeId: songDetailModelId)
class SongDetailsModel extends Equatable {
  @HiveField(0)
  String title;
  @HiveField(1)
  String album;
  @HiveField(2)
  String artists;
  @HiveField(3)
  List<String> genres;
  @HiveField(4)
  String imagePath;
  @HiveField(5)
  int songID;
  @HiveField(6)
  String path;
  @HiveField(7)
  bool isLiked;
  SongDetailsModel({
    this.album,
    this.artists,
    this.genres,
    this.imagePath,
    this.path,
    this.songID,
    this.title,
    this.isLiked
  });
  @override
  List<Object> get props =>
      [album, artists, genres, imagePath, path, songID, title, isLiked];
}
