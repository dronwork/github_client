// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'github.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GitHubAdapter extends TypeAdapter<GitHub> {
  @override
  final typeId = 0;

  @override
  GitHub read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return GitHub(
      id: fields[0] as int,
      fullName: fields[1] as String,
      name: fields[2] as String,
      description: fields[3] as String,
      language: fields[4] as String,
      forksCount: fields[5] as int,
      stargazersCount: fields[6] as int,
      commits: fields[7] as int,
      login: fields[8] as String,
      avatarUrl: fields[9] as String,
    );
  }

  @override
  void write(BinaryWriter writer, GitHub obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.fullName)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.description)
      ..writeByte(4)
      ..write(obj.language)
      ..writeByte(5)
      ..write(obj.forksCount)
      ..writeByte(6)
      ..write(obj.stargazersCount)
      ..writeByte(7)
      ..write(obj.commits)
      ..writeByte(8)
      ..write(obj.login)
      ..writeByte(9)
      ..write(obj.avatarUrl);
  }
}
