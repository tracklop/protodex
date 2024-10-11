import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/pokemon.dart';
import '../viewmodels/favorites_viewmodel.dart';

class PokemonDetailView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Pokemon pokemon =
        ModalRoute.of(context)!.settings.arguments as Pokemon;
    final favoritesViewModel = Provider.of<FavoritesViewModel>(context);

    bool isFavorite = favoritesViewModel.isFavorite(pokemon);

    return Scaffold(
      appBar: AppBar(
        title: Text(pokemon.name),
      ),
      body: Center(
        child: Column(
          children: [
            Image.network(pokemon.imageUrl),
            Text(pokemon.name),
            if (isFavorite)
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  decoration: InputDecoration(labelText: 'Nom personnalisé'),
                  onChanged: (value) {
                    pokemon.customName = value;
                  },
                ),
              ),
            ElevatedButton(
              onPressed: () {
                if (isFavorite) {
                  favoritesViewModel.removeFavorite(pokemon);
                } else {
                  favoritesViewModel.addFavorite(pokemon);
                }
              },
              child: Text(
                  isFavorite ? 'Retirer des Favoris' : 'Ajouter aux Favoris'),
            ),
          ],
        ),
      ),
    );
  }
}
