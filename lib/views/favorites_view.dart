import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/favorites_viewmodel.dart';
import '../services/pokeapi_service.dart';
import '../models/pokemon.dart';
import '../utils/color_utils.dart';

class FavoritesView extends StatelessWidget {
  final PokeApiService apiService = PokeApiService();

  FavoritesView({super.key});

  @override
  Widget build(BuildContext context) {
    final favoritesViewModel = Provider.of<FavoritesViewModel>(context);
    int favoritesCount = favoritesViewModel.favoritePokemonIds.length;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pokémon Favoris'),
      ),
      body: favoritesCount == 0
          ? const Center(child: Text('Aucun Pokémon favori'))
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Total de Favoris : $favoritesCount',
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: favoritesViewModel.favoritePokemonIds.length,
                    itemBuilder: (context, index) {
                      final int pokemonId =
                          favoritesViewModel.favoritePokemonIds[index];
                      return FutureBuilder<Pokemon>(
                        future: apiService.fetchPokemonDetails(pokemonId),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else if (snapshot.hasError) {
                            return const ListTile(
                              title: Text('Erreur lors du chargement'),
                            );
                          } else {
                            final pokemon = snapshot.data!;
                            return Container(
                              margin: const EdgeInsets.all(5.0),
                              padding: const EdgeInsets.all(15.0),
                              decoration: BoxDecoration(
                                gradient: pokemon.types.length > 1
                                    ? LinearGradient(
                                        begin: Alignment.bottomLeft,
                                        end: Alignment.topRight,
                                        colors: [
                                          getColorForType(pokemon.types[0]),
                                          getColorForType(pokemon.types[1]),
                                        ],
                                        stops: const [0.25, 0.75],
                                      )
                                    : null,
                                color: pokemon.types.length == 1
                                    ? getColorForType(pokemon.types[0])
                                    : null,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: ListTile(
                                leading: Image.network(pokemon.imageUrl),
                                title: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      pokemon.name,
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Row(
                                      children: pokemon.types.map((type) {
                                        return Container(
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 4,
                                            horizontal: 8,
                                          ),
                                          margin: const EdgeInsets.only(
                                              right: 4),
                                          decoration: BoxDecoration(
                                            color: getColorForType(type),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            border: Border.all(
                                                color: Colors.white, width: 1),
                                          ),
                                          child: Text(
                                            type.toUpperCase(),
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 8,
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                  ],
                                ),
                                trailing: IconButton(
                                  icon: const Icon(
                                    Icons.star,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {
                                    favoritesViewModel
                                        .removeFavoriteById(pokemonId);
                                  },
                                ),
                                onTap: () {
                                  Navigator.pushNamed(context, '/details',
                                      arguments: pokemon);
                                },
                              ),
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
