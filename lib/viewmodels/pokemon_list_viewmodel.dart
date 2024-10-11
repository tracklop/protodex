import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/pokemon_list_item.dart';
import '../services/pokeapi_service.dart';

class PokemonListViewModel extends ChangeNotifier {
  List<PokemonListItem> pokemonList = [];
  bool isLoading = false;
  String errorMessage = '';
  final PokeApiService apiService = PokeApiService();

  int offset = 0;
  final int limit = 20;
  int totalCount = 0;
  bool hasMore = true;

  PokemonListViewModel() {
    fetchPokemonList();
  }

  Future<void> fetchPokemonList() async {
    if (isLoading || !hasMore) return;

    isLoading = true;
    notifyListeners();

    try {
      final response = await http.get(Uri.parse(
          '${apiService.baseUrl}/pokemon?offset=$offset&limit=$limit'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        totalCount = data['count'];
        List<dynamic> results = data['results'];

        results.forEach((item) {
          int id = extractIdFromUrl(item['url']);
          String name = item['name'];
          String imageUrl =
              'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/$id.png';

          pokemonList.add(PokemonListItem(
            id: id,
            name: name,
            imageUrl: imageUrl,
          ));
        });

        offset += limit;
        if (pokemonList.length >= totalCount) {
          hasMore = false;
        }
      } else {
        errorMessage = 'Erreur lors du chargement de la liste des Pokémon.';
      }
    } catch (e) {
      errorMessage = 'Erreur lors du chargement de la liste des Pokémon.';
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  int extractIdFromUrl(String url) {
    Uri uri = Uri.parse(url);
    List<String> segments = uri.pathSegments;
    return int.parse(segments[segments.length - 2]);
  }
}
