class Province {
  final String id;
  final String text;

  Province({required this.id, required this.text});

  factory Province.fromJson(Map<String, dynamic> json) {
    return Province(
      id: json['id'],
      text: json['text'],
    );
  }
}
