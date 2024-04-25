// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'single_image_offer.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SingleImageOfferAdapter extends TypeAdapter<SingleImageOffer> {
  @override
  final int typeId = 5;

  @override
  SingleImageOffer read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SingleImageOffer(
      title: fields[0] as String,
      subTitle: fields[1] as String,
      image: fields[2] as String,
      category: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, SingleImageOffer obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.subTitle)
      ..writeByte(2)
      ..write(obj.image)
      ..writeByte(3)
      ..write(obj.category);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SingleImageOfferAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
