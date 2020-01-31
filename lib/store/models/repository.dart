class Repository {
  final String name;
  final String description;
  final String language;
  final int forksCount;
  final int stargazersCount;

  Repository({
    this.name,
    this.description,
    this.language,
    this.forksCount,
    this.stargazersCount,
  });

  factory Repository.fromJson(Map<String, dynamic> json) => Repository(
        name: json['name'] as String,
        description: json['description'] as String,
        language: json['language'] as String,
        forksCount: json['forks_count'] as int,
        stargazersCount: json['stargazers_count'] as int,
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'name': this.name,
        'description': this.description,
        'language': this.language,
        'forks_count': this.forksCount,
        'stargazers_count': this.stargazersCount,
      };
}
