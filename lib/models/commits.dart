import 'package:intl/intl.dart';

class Commits {
  final Commit commit;

  Commits({this.commit});

  factory Commits.fromJson(Map<String, dynamic> json) => Commits(
        commit: Commit.fromJson(json['commit']),
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'commit': this.commit,
      };
}

class Commit {
  final Author author;
  final String message;

  Commit({this.author, this.message});

  factory Commit.fromJson(Map<String, dynamic> json) => Commit(
        author: Author.fromJson(json['author']),
        message: json['message'] as String,
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'author': this.author,
        'message': this.message,
      };
}

class Author {
  final String name;
  final String email;
  final String date;

  Author({this.name, this.email, this.date});

  factory Author.fromJson(Map<String, dynamic> json) => Author(
        name: json['name'] as String,
        email: json['email'] as String,
        date: json['date'] as String,
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'name': this.name,
        'email': this.email,
        'date': this.date,
      };

  String get dateAtFormatted => DateFormat.yMMMd().format(DateTime.parse(date));
}
