// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'album_art_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AlbumArtModelAdapter extends TypeAdapter<AlbumArtModel> {
  @override
  final int typeId = 2;

  @override
  AlbumArtModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AlbumArtModel(
      image: fields[0] as Image,
    );
  }

  @override
  void write(BinaryWriter writer, AlbumArtModel obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.image);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AlbumArtModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
