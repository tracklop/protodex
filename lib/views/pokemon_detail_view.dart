import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/pokemon.dart';
import '../viewmodels/favorites_viewmodel.dart';
import '../viewmodels/captured_viewmodel.dart';

class PokemonDetailView extends StatelessWidget {
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
            SizedBox(height: 16),
            Text(
              '#${pokemon.id} ${pokemon.name}',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text('Types: ${pokemon.types.join(', ')}'),
            SizedBox(height: 16),
            Text('Capacités: ${pokemon.abilities.join(', ')}'),
            SizedBox(height: 16),
            Text(
              'Statistiques:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            ...pokemon.stats.entries.map((entry) {
              return Text('${entry.key}: ${entry.value}');
            }).toList(),
            SizedBox(height: 16),
            CheckboxListTile(
              title: Text('Favori'),
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
              title: Text('Capturé'),
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
