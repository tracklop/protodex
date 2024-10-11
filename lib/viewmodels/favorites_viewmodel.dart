import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/pokemon.dart';

class FavoritesViewModel extends ChangeNotifier {
  List<int> favoritePokemonIds = [];

  FavoritesViewModel() {
    _loadFavorites();
  }

  void addFavorite(Pokemon pokemon) {
    if (!favoritePokemonIds.contains(pokemon.id)) {
      favoritePokemonIds.add(pokemon.id);
      _saveFavorites();
      notifyListeners();
    }
  }

  void removeFavorite(Pokemon pokemon) {
    favoritePokemonIds.remove(pokemon.id);
    _saveFavorites();
    notifyListeners();
  }

  bool isFavorite(Pokemon pokemon) {
    return favoritePokemonIds.contains(pokemon.id);
  }

  void addFavoriteById(int pokemonId) {
    if (!favoritePokemonIds.contains(pokemonId)) {
      favoritePokemonIds.add(pokemonId);
      _saveFavorites();
      notifyListeners();
    }
  }

  void removeFavoriteById(int pokemonId) {
    favoritePokemonIds.remove(pokemonId);
    _saveFavorites();
    notifyListeners();
  }

  bool isFavoriteById(int pokemonId) {
    return favoritePokemonIds.contains(pokemonId);
  }

  void _loadFavorites() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    favoritePokemonIds =
        prefs.getStringList('favoritePokemonIds')?.map(int.parse).toList() ??
            [];
    notifyListeners();
  }

  void _saveFavorites() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList('favoritePokemonIds',
        favoritePokemonIds.map((id) => id.toString()).toList());
  }
}
