class PostalCode {
  final String id;
  final String text;

  PostalCode({required this.id, required this.text});

  factory PostalCode.fromJson(Map<String, dynamic> json) {
    return PostalCode(
      id: json['id'],
      text: json['text'],
    );
  }
}
