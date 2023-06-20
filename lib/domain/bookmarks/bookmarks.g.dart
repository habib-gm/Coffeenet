// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bookmarks.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BookmarksAdapter extends TypeAdapter<Bookmarks> {
  @override
  final int typeId = 1;

  @override
  Bookmarks read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Bookmarks(
      bookmarkId: fields[0] as String,
      leaf: fields[1] as DetectedLeaf,
      time: fields[2] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, Bookmarks obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.bookmarkId)
      ..writeByte(1)
      ..write(obj.leaf)
      ..writeByte(2)
      ..write(obj.time);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BookmarksAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
