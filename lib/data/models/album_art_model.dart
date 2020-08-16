import 'package:SpotifyClone/core/constants.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';

part 'album_art_model.g.dart';

@HiveType(typeId: albumArtModelId)
// ignore: must_be_immutable
class AlbumArtModel extends Equatable {
  @HiveField(0)
  Image image;
  @override
  List<Object> get props => [image];
}
