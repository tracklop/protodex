import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/pokemon.dart';
import '../viewmodels/favorites_viewmodel.dart';
import '../viewmodels/captured_viewmodel.dart';

class PokemonDetailView extends StatelessWidget {
  const PokemonDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    final Pokemon pokemon =
        ModalRoute.of(context)!.settings.arguments as Pokemon;
    final favoritesViewModel = Provider.of<FavoritesViewModel>(context);
    final capturedViewModel = Provider.of<CapturedViewModel>(context);

    bool isFavorite = favoritesViewModel.isFavorite(pokemon);
    bool isCaptured = capturedViewModel.isCaptured(pokemon);

    return Scaffold(
      appBar: AppBar(
        title: Text(pokemon.name),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(pokemon.imageUrl),
            const SizedBox(height: 16),
            Text(
              '#${pokemon.id} ${pokemon.name}',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text('Types: ${pokemon.types.join(', ')}'),
            const SizedBox(height: 16),
            Text('Capacités: ${pokemon.abilities.join(', ')}'),
            const SizedBox(height: 16),
            const Text(
              'Statistiques:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            ...pokemon.stats.entries.map((entry) {
              return Text('${entry.key}: ${entry.value}');
            }).toList(),
            const SizedBox(height: 16),
            CheckboxListTile(
              title: const Text('Favori'),
              value: isFavorite,
              onChanged: (value) {
                if (value == true) {
                  favoritesViewModel.addFavorite(pokemon);
                } else {
                  favoritesViewModel.removeFavorite(pokemon);
                }
              },
            ),
            CheckboxListTile(
              title: const Text('Capturé'),
              value: isCaptured,
              onChanged: (value) {
                if (value == true) {
                  capturedViewModel.addCaptured(pokemon);
                } else {
                  capturedViewModel.removeCaptured(pokemon);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
