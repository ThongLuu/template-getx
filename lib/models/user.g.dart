// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserAdapter extends TypeAdapter<User> {
  @override
  final int typeId = 6;

  @override
  User read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return User(
      id: fields[0] as String,
      name: fields[1] as String,
      email: fields[2] as String,
      password: fields[3] as String,
      address: fields[4] as String,
      type: fields[5] as String,
      token: fields[6] as String,
      cart: (fields[7] as List).cast<dynamic>(),
      saveForLater: (fields[8] as List).cast<dynamic>(),
      keepShoppingFor: (fields[9] as List).cast<dynamic>(),
      wishList: (fields[10] as List).cast<dynamic>(),
    );
  }

  @override
  void write(BinaryWriter writer, User obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.email)
      ..writeByte(3)
      ..write(obj.password)
      ..writeByte(4)
      ..write(obj.address)
      ..writeByte(5)
      ..write(obj.type)
      ..writeByte(6)
      ..write(obj.token)
      ..writeByte(7)
      ..write(obj.cart)
      ..writeByte(8)
      ..write(obj.saveForLater)
      ..writeByte(9)
      ..write(obj.keepShoppingFor)
      ..writeByte(10)
      ..write(obj.wishList);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
