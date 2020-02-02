class Contributors {
  final int contributions;

  Contributors({this.contributions});

  factory Contributors.fromJson(Map<String, dynamic> json) => Contributors(
        contributions: json['contributions'] as int,
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'contributions': this.contributions,
      };
}
