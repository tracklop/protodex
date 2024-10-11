import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/favorites_viewmodel.dart';
import '../services/pokeapi_service.dart';
import '../models/pokemon.dart';

class FavoritesView extends StatelessWidget {
  final PokeApiService apiService = PokeApiService();

  @override
  Widget build(BuildContext context) {
    final favoritesViewModel = Provider.of<FavoritesViewModel>(context);

    int favoritesCount = favoritesViewModel.favoritePokemonIds.length;

    return Scaffold(
      appBar: AppBar(
        title: Text('Pokémon Favoris'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Total de Favoris : $favoritesCount',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: favoritesViewModel.favoritePokemonIds.isEmpty
                ? Center(child: Text('Aucun Pokémon favori'))
                : ListView.builder(
                    itemCount: favoritesViewModel.favoritePokemonIds.length,
                    itemBuilder: (context, index) {
                      final int pokemonId =
                          favoritesViewModel.favoritePokemonIds[index];
                      return FutureBuilder<Pokemon>(
                        future: apiService.fetchPokemonDetails(pokemonId),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return ListTile(
                              title: Text('Chargement...'),
                            );
                          } else if (snapshot.hasError) {
                            return ListTile(
                              title: Text('Erreur lors du chargement'),
                            );
                          } else {
                            final pokemon = snapshot.data!;
                            return ListTile(
                              title: Text(pokemon.name),
                              leading: Image.network(pokemon.imageUrl),
                              onTap: () {
                                Navigator.pushNamed(context, '/details',
                                    arguments: pokemon);
                              },
                            );
                          }
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
