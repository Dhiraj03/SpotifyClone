// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'playlist_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PlaylistModelAdapter extends TypeAdapter<PlaylistModel> {
  @override
  final int typeId = 3;

  @override
  PlaylistModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PlaylistModel()
      ..albumID = fields[0] as int
      ..songs = (fields[1] as List)?.cast<SongDetailsModel>()
      ..imagePath = fields[2] as String
      ..isAlbum = fields[3] as bool
      ..genres = (fields[4] as List)?.cast<String>()
      ..name = fields[5] as String;
  }

  @override
  void write(BinaryWriter writer, PlaylistModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.albumID)
      ..writeByte(1)
      ..write(obj.songs)
      ..writeByte(2)
      ..write(obj.imagePath)
      ..writeByte(3)
      ..write(obj.isAlbum)
      ..writeByte(4)
      ..write(obj.genres)
      ..writeByte(5)
      ..write(obj.name);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PlaylistModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
