import 'package:flutter/material.dart';
import '../services/pokeapi_service.dart';

class TotalCountViewModel extends ChangeNotifier {
  int totalCount = 0;
  final PokeApiService apiService = PokeApiService();

  TotalCountViewModel() {
    fetchTotalCount();
  }

  Future<void> fetchTotalCount() async {
    try {
      totalCount = await apiService.fetchTotalPokemonCount();
      notifyListeners();
    } catch (e) {
      // Gérer l'erreur si nécessaire
    }
  }
}
