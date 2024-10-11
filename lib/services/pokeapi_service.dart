import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/pokemon.dart';

class PokeApiService {
  final String baseUrl = 'https://pokeapi.co/api/v2';

  Future<List<Pokemon>> fetchPokemonList() async {
    final response = await http.get(Uri.parse('$baseUrl/pokemon?limit=100'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      List<Pokemon> pokemonList = [];
      for (var item in data['results']) {
        pokemonList.add(Pokemon.fromJson(item));
      }
      return pokemonList;
    } else {
      throw Exception('Échec du chargement de la liste des Pokémon');
    }
  }
}
