// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'offline_recipe.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class OfflinerecipeAdapter extends TypeAdapter<Offlinerecipe> {
  @override
  final int typeId = 0;

  @override
  Offlinerecipe read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Offlinerecipe(
      id: fields[0] as int,
      title: fields[1] as String,
      readyInMinutes: fields[2] as num,
      servings: fields[3] as num,
      sourceUrl: fields[4] as String,
      image: fields[5] as String,
      imageType: fields[6] as String,
      summary: fields[7] as String,
      cuisines: (fields[8] as List).cast<dynamic>(),
      dishTypes: (fields[9] as List).cast<String>(),
      diets: (fields[10] as List).cast<String>(),
      occasions: (fields[11] as List).cast<dynamic>(),
      instructions: fields[12] as dynamic,
      analyzedInstructions: (fields[13] as List).cast<dynamic>(),
      originalId: fields[14] as dynamic,
    );
  }

  @override
  void write(BinaryWriter writer, Offlinerecipe obj) {
    writer
      ..writeByte(15)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.readyInMinutes)
      ..writeByte(3)
      ..write(obj.servings)
      ..writeByte(4)
      ..write(obj.sourceUrl)
      ..writeByte(5)
      ..write(obj.image)
      ..writeByte(6)
      ..write(obj.imageType)
      ..writeByte(7)
      ..write(obj.summary)
      ..writeByte(8)
      ..write(obj.cuisines)
      ..writeByte(9)
      ..write(obj.dishTypes)
      ..writeByte(10)
      ..write(obj.diets)
      ..writeByte(11)
      ..write(obj.occasions)
      ..writeByte(12)
      ..write(obj.instructions)
      ..writeByte(13)
      ..write(obj.analyzedInstructions)
      ..writeByte(14)
      ..write(obj.originalId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OfflinerecipeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
