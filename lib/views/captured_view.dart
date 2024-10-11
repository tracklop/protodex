import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/captured_viewmodel.dart';
import '../viewmodels/total_count_viewmodel.dart';
import '../services/pokeapi_service.dart';
import '../models/pokemon.dart';

class CapturedView extends StatelessWidget {
  final PokeApiService apiService = PokeApiService();

  @override
  Widget build(BuildContext context) {
    final capturedViewModel = Provider.of<CapturedViewModel>(context);
    final totalCountViewModel = Provider.of<TotalCountViewModel>(context);

    int capturedCount = capturedViewModel.capturedPokemonIds.length;
    int totalCount = totalCountViewModel.totalCount;

    double progress = totalCount > 0 ? (capturedCount / totalCount) * 100 : 0;

    return Scaffold(
      appBar: AppBar(
        title: Text('Pokémon Capturés'),
      ),
      body: totalCount == 0
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Text(
                        'Progression : ${progress.toStringAsFixed(1)}% (${capturedCount}/$totalCount)',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10),
                      LinearProgressIndicator(
                        value: progress / 100,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: capturedViewModel.capturedPokemonIds.isEmpty
                      ? Center(child: Text('Aucun Pokémon capturé'))
                      : ListView.builder(
                          itemCount:
                              capturedViewModel.capturedPokemonIds.length,
                          itemBuilder: (context, index) {
                            final int pokemonId =
                                capturedViewModel.capturedPokemonIds[index];
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
