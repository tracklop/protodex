import 'package:flutter/material.dart';
import '../models/pokemon.dart';

class FavoritesViewModel extends ChangeNotifier {
  List<Pokemon> favorites = [];

  void addFavorite(Pokemon pokemon) {
    favorites.add(pokemon);
    notifyListeners();
  }

  void removeFavorite(Pokemon pokemon) {
    favorites.removeWhere((item) => item.id == pokemon.id);
    notifyListeners();
  }

  bool isFavorite(Pokemon pokemon) {
    return favorites.any((item) => item.id == pokemon.id);
  }
}
