import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/pokemon.dart';

class PokeApiService {
  final String baseUrl = 'https://pokeapi.co/api/v2';

  Future<List<Map<String, dynamic>>> fetchPokemonList(
      int offset, int limit) async {
    final response = await http
        .get(Uri.parse('$baseUrl/pokemon?offset=$offset&limit=$limit'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return List<Map<String, dynamic>>.from(data['results']);
    } else {
      throw Exception('Échec du chargement de la liste des Pokémon');
    }
  }

  Future<Pokemon> fetchPokemonDetails(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/pokemon/$id'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return Pokemon.fromJson(data);
    } else {
      throw Exception('Échec du chargement des détails du Pokémon');
    }
  }
}
