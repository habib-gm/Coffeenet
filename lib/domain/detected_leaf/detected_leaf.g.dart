// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'detected_leaf.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DetectedLeafAdapter extends TypeAdapter<DetectedLeaf> {
  @override
  final int typeId = 0;

  @override
  DetectedLeaf read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DetectedLeaf(
      coffeeLeafId: fields[0] as String,
      filename: fields[1] as String,
      filesize: fields[2] as String,
      uploadtime: fields[3] as int,
      originalimagelocation: fields[4] as String,
      detectedimagelocation: fields[5] as String,
      diseases: (fields[6] as List).cast<String>(),
      bookmarked: fields[7] as bool,
      scanned: fields[8] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, DetectedLeaf obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.coffeeLeafId)
      ..writeByte(1)
      ..write(obj.filename)
      ..writeByte(2)
      ..write(obj.filesize)
      ..writeByte(3)
      ..write(obj.uploadtime)
      ..writeByte(4)
      ..write(obj.originalimagelocation)
      ..writeByte(5)
      ..write(obj.detectedimagelocation)
      ..writeByte(6)
      ..write(obj.diseases)
      ..writeByte(7)
      ..write(obj.bookmarked)
      ..writeByte(8)
      ..write(obj.scanned);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DetectedLeafAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
