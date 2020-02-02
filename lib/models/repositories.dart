class Repositories {
  final int id;
  final String fullName;

  Repositories({this.id, this.fullName});

  factory Repositories.fromJson(Map<String, dynamic> json) => Repositories(
        id: json['id'] as int,
        fullName: json['full_name'] as String,
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': this.id,
        'full_name': this.fullName,
      };
}
