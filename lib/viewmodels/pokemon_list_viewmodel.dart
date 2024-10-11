import 'package:flutter/material.dart';
import '../models/pokemon.dart';
import '../services/pokeapi_service.dart';

class PokemonListViewModel extends ChangeNotifier {
  List<Pokemon> pokemonList = [];
  bool isLoading = false;
  String errorMessage = '';
  final PokeApiService apiService = PokeApiService();

  PokemonListViewModel() {
    fetchPokemonList();
  }

  Future<void> fetchPokemonList() async {
    isLoading = true;
    notifyListeners();

    try {
      pokemonList = await apiService.fetchPokemonList();
    } catch (e) {
      errorMessage = 'Erreur lors du chargement de la liste des Pokémon.';
      print('Erreur: $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
