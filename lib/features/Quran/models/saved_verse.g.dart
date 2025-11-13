// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'saved_verse.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SavedVerseAdapter extends TypeAdapter<SavedVerse> {
  @override
  final int typeId = 10;

  @override
  SavedVerse read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SavedVerse(
      verseText: fields[0] as String,
      surahName: fields[1] as String,
      surahNumber: fields[2] as int,
      verseNumber: fields[3] as int,
      pageNumber: fields[4] as int,
      savedAt: fields[5] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, SavedVerse obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.verseText)
      ..writeByte(1)
      ..write(obj.surahName)
      ..writeByte(2)
      ..write(obj.surahNumber)
      ..writeByte(3)
      ..write(obj.verseNumber)
      ..writeByte(4)
      ..write(obj.pageNumber)
      ..writeByte(5)
      ..write(obj.savedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SavedVerseAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
