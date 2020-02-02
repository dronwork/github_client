class Repository {
  final String name;
  final String description;
  final String language;
  final int forksCount;
  final int stargazersCount;
  final Owner owner;

  Repository({
    this.name,
    this.description,
    this.language,
    this.forksCount,
    this.stargazersCount,
    this.owner,
  });

  factory Repository.fromJson(Map<String, dynamic> json) => Repository(
        name: json['name'] as String,
        description: json['description'] as String,
        language: json['language'] as String,
        forksCount: json['forks_count'] as int,
        stargazersCount: json['stargazers_count'] as int,
        owner: Owner.fromJson(json['owner']),
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'name': this.name,
        'description': this.description,
        'language': this.language,
        'forks_count': this.forksCount,
        'stargazers_count': this.stargazersCount,
        'owner': this.owner,
      };
}

class Owner {
  final String login;
  final String avatarUrl;

  Owner({this.login, this.avatarUrl});

  factory Owner.fromJson(Map<String, dynamic> json) {
    return Owner(
      login: json['login'] as String,
      avatarUrl: json['avatar_url'] as String,
    );
  }
}
