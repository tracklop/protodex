import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/captured_viewmodel.dart';
import '../viewmodels/total_count_viewmodel.dart';
import '../services/pokeapi_service.dart';
import '../models/pokemon.dart';
import '../utils/color_utils.dart';

class CapturedView extends StatelessWidget {
  final PokeApiService apiService = PokeApiService();

  CapturedView({super.key});

  @override
  Widget build(BuildContext context) {
    final capturedViewModel = Provider.of<CapturedViewModel>(context);
    final totalCountViewModel = Provider.of<TotalCountViewModel>(context);

    int capturedCount = capturedViewModel.capturedPokemonIds.length;
    int totalCount = totalCountViewModel.totalCount;

    double progress = totalCount > 0 ? (capturedCount / totalCount) * 100 : 0;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pokémon Capturés'),
      ),
      body: totalCount == 0
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Text(
                        'Progression : ${progress.toStringAsFixed(1)}% ($capturedCount/$totalCount)',
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      LinearProgressIndicator(
                        value: progress / 100,
                        backgroundColor: Colors.grey.shade300,
                        color: Colors.blue,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: capturedViewModel.capturedPokemonIds.isEmpty
                      ? const Center(child: Text('Aucun Pokémon capturé'))
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
                                                getColorForType(
                                                    pokemon.types[0]),
                                                getColorForType(
                                                    pokemon.types[1]),
                                              ],
                                              stops: const [0.25, 0.75],
                                            )
                                          : null,
                                      color: pokemon.types.length == 1
                                          ? getColorForType(
                                              pokemon.types[0])
                                          : null,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: ListTile(
                                      leading: Image.network(
                                        pokemon.imageUrl,
                                        width: 50,
                                        height: 50,
                                      ),
                                      title: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
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
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                  vertical: 4,
                                                  horizontal: 8,
                                                ),
                                                margin: const EdgeInsets.only(
                                                    right: 4),
                                                decoration: BoxDecoration(
                                                  color:
                                                      getColorForType(type),
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  border: Border.all(
                                                      color: Colors.white,
                                                      width: 1),
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
                                          Icons.catching_pokemon,
                                          color: Colors.red,
                                        ),
                                        onPressed: () {
                                          capturedViewModel
                                              .removeCapturedById(pokemonId);
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
