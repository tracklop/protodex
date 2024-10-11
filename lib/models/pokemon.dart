class Pokemon {
  final int id;
  String name;
  String customName;
  final String imageUrl;

  Pokemon({
    required this.id,
    required this.name,
    required this.imageUrl,
    this.customName = '',
  });

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    String url = json['url'];
    Uri uri = Uri.parse(url);
    List<String> segments = uri.pathSegments;
    int id = int.parse(segments[segments.length - 2]);

    return Pokemon(
      id: id,
      name: json['name'],
      imageUrl:
          'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/$id.png',
    );
  }
}
