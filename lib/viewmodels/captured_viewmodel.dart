import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/pokemon.dart';

class CapturedViewModel extends ChangeNotifier {
  List<int> capturedPokemonIds = [];

  CapturedViewModel() {
    _loadCaptured();
  }

  void addCaptured(Pokemon pokemon) {
    if (!capturedPokemonIds.contains(pokemon.id)) {
      capturedPokemonIds.add(pokemon.id);
      _saveCaptured();
      notifyListeners();
    }
  }

  void removeCaptured(Pokemon pokemon) {
    capturedPokemonIds.remove(pokemon.id);
    _saveCaptured();
    notifyListeners();
  }

  bool isCaptured(Pokemon pokemon) {
    return capturedPokemonIds.contains(pokemon.id);
  }

  void addCapturedById(int pokemonId) {
    if (!capturedPokemonIds.contains(pokemonId)) {
      capturedPokemonIds.add(pokemonId);
      _saveCaptured();
      notifyListeners();
    }
  }

  void removeCapturedById(int pokemonId) {
    capturedPokemonIds.remove(pokemonId);
    _saveCaptured();
    notifyListeners();
  }

  bool isCapturedById(int pokemonId) {
    return capturedPokemonIds.contains(pokemonId);
  }

  void _loadCaptured() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    capturedPokemonIds =
        prefs.getStringList('capturedPokemonIds')?.map(int.parse).toList() ??
            [];
    notifyListeners();
  }

  void _saveCaptured() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList('capturedPokemonIds',
        capturedPokemonIds.map((e) => e.toString()).toList());
  }
}
