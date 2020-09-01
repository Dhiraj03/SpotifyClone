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
      album: fields[1] as String,
      artists: fields[2] as String,
      genres: (fields[3] as List)?.cast<String>(),
      imagePath: fields[4] as String,
      path: fields[6] as String,
      songID: fields[5] as int,
      title: fields[0] as String,
      isLiked: fields[7] as bool,
      colors: fields[8] as String,
    );
  }

  @override
  void write(BinaryWriter writer, SongDetailsModel obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.album)
      ..writeByte(2)
      ..write(obj.artists)
      ..writeByte(3)
      ..write(obj.genres)
      ..writeByte(4)
      ..write(obj.imagePath)
      ..writeByte(5)
      ..write(obj.songID)
      ..writeByte(6)
      ..write(obj.path)
      ..writeByte(7)
      ..write(obj.isLiked)
      ..writeByte(8)
      ..write(obj.colors);
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
