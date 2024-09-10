class SubDistrict {
  final String id;
  final String text;

  SubDistrict({required this.id, required this.text});

  factory SubDistrict.fromJson(Map<String, dynamic> json) {
    return SubDistrict(
      id: json['id'],
      text: json['text'],
    );
  }
}
