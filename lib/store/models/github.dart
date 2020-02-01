class GitHub {
  final int id;
  final String fullName;
  final String name;
  final String description;
  final String language;
  final int forksCount;
  final int stargazersCount;
  final int commits;

  GitHub({
    this.id,
    this.fullName,
    this.name,
    this.description,
    this.language,
    this.forksCount,
    this.stargazersCount,
    this.commits,
  });

  factory GitHub.fromJson(Map<String, dynamic> json) => GitHub(
        id: json['id'] as int,
        fullName: json['full_name'] as String,
        name: json['name'] as String,
        description: json['description'] as String,
        language: json['language'] as String,
        forksCount: json['forks_count'] as int,
        stargazersCount: json['stargazers_count'] as int,
        commits: json['commits'] as int,
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': this.id,
        'full_name': this.fullName,
        'name': this.name,
        'description': this.description,
        'language': this.language,
        'forks_count': this.forksCount,
        'stargazers_count': this.stargazersCount,
        'commits': this.commits,
      };
}
