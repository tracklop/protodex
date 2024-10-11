class Pokemon {
  final int id;
  final String name;
  final String imageUrl;
  final List<String> types;
  final List<String> abilities;
  final Map<String, int> stats;

  Pokemon({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.types,
    required this.abilities,
    required this.stats,
  });

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    int id = json['id'];

    String imageUrl = json['sprites']['front_default'] ?? '';

    List<String> types = (json['types'] as List)
        .map((typeInfo) => typeInfo['type']['name'] as String)
        .toList();

    List<String> abilities = (json['abilities'] as List)
        .map((abilityInfo) => abilityInfo['ability']['name'] as String)
        .toList();

    Map<String, int> stats = {};
    for (var statInfo in json['stats']) {
      String statName = statInfo['stat']['name'];
      int statValue = statInfo['base_stat'];
      stats[statName] = statValue;
    }

    return Pokemon(
      id: id,
      name: json['name'],
      imageUrl: imageUrl,
      types: types,
      abilities: abilities,
      stats: stats,
    );
  }
}
