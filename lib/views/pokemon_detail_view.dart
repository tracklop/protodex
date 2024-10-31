import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/pokemon.dart';
import '../viewmodels/favorites_viewmodel.dart';
import '../viewmodels/captured_viewmodel.dart';
import '../utils/color_utils.dart';

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

    // Détermine la couleur de fond selon le premier type du Pokémon, sinon gris
    final backgroundColor = pokemon.types.isNotEmpty
        ? getColorForType(pokemon.types[0])
        : Colors.grey;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          pokemon.name,
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: backgroundColor,
      ),
      backgroundColor: backgroundColor, // Couleur de fond de la page
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(pokemon.imageUrl),
            const SizedBox(height: 16),
            Text(
              '#${pokemon.id} ${pokemon.name}',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 16),
            // Affichage des types avec des couleurs de fond et un contour blanc
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: pokemon.types.map((type) {
                return Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 4,
                    horizontal: 8,
                  ),
                  margin: const EdgeInsets.only(right: 4),
                  decoration: BoxDecoration(
                    color: getColorForType(type),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.white, width: 1),
                  ),
                  child: Text(
                    type.toUpperCase(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 16),
            Text(
              'Capacités: ${pokemon.abilities.join(', ')}',
              style: const TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 16),
            const Text(
              'Statistiques:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            ...pokemon.stats.entries.map((entry) {
              return Text(
                '${entry.key}: ${entry.value}',
                style: const TextStyle(color: Colors.white),
              );
            }).toList(),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Icône pour Favori
                IconButton(
                  icon: Icon(
                    isFavorite ? Icons.star : Icons.star_border,
                    color: isFavorite ? Colors.yellow : Colors.white,
                  ),
                  onPressed: () {
                    if (isFavorite) {
                      favoritesViewModel.removeFavorite(pokemon);
                    } else {
                      favoritesViewModel.addFavorite(pokemon);
                    }
                  },
                ),
                const SizedBox(width: 16),
                // Icône pour Capturé
                IconButton(
                  icon: Icon(
                    isCaptured
                        ? Icons.catching_pokemon
                        : Icons.catching_pokemon_outlined,
                    color: isCaptured ? Colors.red : Colors.white,
                  ),
                  onPressed: () {
                    if (isCaptured) {
                      capturedViewModel.removeCaptured(pokemon);
                    } else {
                      capturedViewModel.addCaptured(pokemon);
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
