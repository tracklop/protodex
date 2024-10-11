import 'package:flutter/material.dart';
import '../models/pokemon.dart';

class FavoritesViewModel extends ChangeNotifier {
  List<int> favoritePokemonIds = [];

  void addFavorite(Pokemon pokemon) {
    if (!favoritePokemonIds.contains(pokemon.id)) {
      favoritePokemonIds.add(pokemon.id);
      notifyListeners();
    }
  }

  void removeFavorite(Pokemon pokemon) {
    favoritePokemonIds.remove(pokemon.id);
    notifyListeners();
  }

  bool isFavorite(Pokemon pokemon) {
    return favoritePokemonIds.contains(pokemon.id);
  }

  void addFavoriteById(int pokemonId) {
    if (!favoritePokemonIds.contains(pokemonId)) {
      favoritePokemonIds.add(pokemonId);
      notifyListeners();
    }
  }

  void removeFavoriteById(int pokemonId) {
    favoritePokemonIds.remove(pokemonId);
    notifyListeners();
  }

  bool isFavoriteById(int pokemonId) {
    return favoritePokemonIds.contains(pokemonId);
  }
}
