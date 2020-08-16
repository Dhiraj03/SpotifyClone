// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'album_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AlbumModelAdapter extends TypeAdapter<AlbumModel> {
  @override
  final int typeId = 3;

  @override
  AlbumModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AlbumModel()
      ..albumID = fields[0] as int
      ..songs = (fields[1] as List)?.cast<SongDetailsModel>()
      ..albumArt = fields[2] as AlbumArtModel;
  }

  @override
  void write(BinaryWriter writer, AlbumModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.albumID)
      ..writeByte(1)
      ..write(obj.songs)
      ..writeByte(2)
      ..write(obj.albumArt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AlbumModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
