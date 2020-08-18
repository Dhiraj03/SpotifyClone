// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'song_details_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SongDetailsModelAdapter extends TypeAdapter<SongDetailsModel> {
  @override
  final int typeId = 1;

  @override
  SongDetailsModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SongDetailsModel(
      albumArt: fields[1] as AlbumArtModel,
      genres: (fields[2] as List)?.cast<String>(),
      song: fields[0] as Audio,
      songID: fields[3] as int,
    );
  }

  @override
  void write(BinaryWriter writer, SongDetailsModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.song)
      ..writeByte(1)
      ..write(obj.albumArt)
      ..writeByte(2)
      ..write(obj.genres)
      ..writeByte(3)
      ..write(obj.songID);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SongDetailsModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
