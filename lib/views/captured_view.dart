import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/captured_viewmodel.dart';
import '../services/pokeapi_service.dart';
import '../models/pokemon.dart';

class CapturedView extends StatelessWidget {
  final PokeApiService apiService = PokeApiService();

  @override
  Widget build(BuildContext context) {
    final capturedViewModel = Provider.of<CapturedViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Pokémon Capturés'),
      ),
      body: capturedViewModel.capturedPokemonIds.isEmpty
          ? Center(child: Text('Aucun Pokémon capturé'))
          : ListView.builder(
              itemCount: capturedViewModel.capturedPokemonIds.length,
              itemBuilder: (context, index) {
                final int pokemonId =
                    capturedViewModel.capturedPokemonIds[index];
                return FutureBuilder<Pokemon>(
                  future: apiService.fetchPokemonDetails(pokemonId),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
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
    );
  }
}
