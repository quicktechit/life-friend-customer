// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lang.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LangAdapter extends TypeAdapter<Lang> {
  @override
  final int typeId = 1;

  @override
  Lang read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Lang(
      languageCode: fields[0] as String?,
      countryCode: fields[1] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Lang obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.languageCode)
      ..writeByte(1)
      ..write(obj.countryCode);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LangAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
