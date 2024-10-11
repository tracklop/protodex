import 'package:flutter/material.dart';
import '../models/pokemon.dart';

class CapturedViewModel extends ChangeNotifier {
  List<int> capturedPokemonIds = [];

  void addCaptured(Pokemon pokemon) {
    if (!capturedPokemonIds.contains(pokemon.id)) {
      capturedPokemonIds.add(pokemon.id);
      notifyListeners();
    }
  }

  void removeCaptured(Pokemon pokemon) {
    capturedPokemonIds.remove(pokemon.id);
    notifyListeners();
  }

  bool isCaptured(Pokemon pokemon) {
    return capturedPokemonIds.contains(pokemon.id);
  }

  void addCapturedById(int pokemonId) {
    if (!capturedPokemonIds.contains(pokemonId)) {
      capturedPokemonIds.add(pokemonId);
      notifyListeners();
    }
  }

  void removeCapturedById(int pokemonId) {
    capturedPokemonIds.remove(pokemonId);
    notifyListeners();
  }

  bool isCapturedById(int pokemonId) {
    return capturedPokemonIds.contains(pokemonId);
  }
}
