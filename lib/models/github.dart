import 'package:hive/hive.dart';

part 'github.g.dart';

@HiveType(typeId: 0)
class GitHub extends HiveObject {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String fullName;
  @HiveField(2)
  final String name;
  @HiveField(3)
  final String description;
  @HiveField(4)
  final String language;
  @HiveField(5)
  final int forksCount;
  @HiveField(6)
  final int stargazersCount;
  @HiveField(7)
  final int commits;
  @HiveField(8)
  final String login;
  @HiveField(9)
  final String avatarUrl;

  GitHub({
    this.id,
    this.fullName,
    this.name,
    this.description,
    this.language,
    this.forksCount,
    this.stargazersCount,
    this.commits,
    this.login,
    this.avatarUrl,
  });
}
