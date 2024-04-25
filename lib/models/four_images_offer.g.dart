// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'four_images_offer.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FourImagesOfferAdapter extends TypeAdapter<FourImagesOffer> {
  @override
  final int typeId = 0;

  @override
  FourImagesOffer read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FourImagesOffer(
      id: fields[0] as String?,
      title: fields[1] as String,
      images: (fields[2] as List).cast<String>(),
      labels: (fields[3] as List).cast<String>(),
      category: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, FourImagesOffer obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.images)
      ..writeByte(3)
      ..write(obj.labels)
      ..writeByte(4)
      ..write(obj.category);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FourImagesOfferAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
