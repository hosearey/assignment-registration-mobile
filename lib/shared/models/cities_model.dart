class City {
  final String id;
  final String text;

  City({required this.id, required this.text});

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      id: json['id'],
      text: json['text'],
    );
  }
}
