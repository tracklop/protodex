import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/favorites_viewmodel.dart';
import '../models/pokemon.dart';

class FavoritesView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final favoritesViewModel = Provider.of<FavoritesViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Pokémon Favoris'),
      ),
      body: favoritesViewModel.favorites.isEmpty
          ? Center(child: Text('Aucun Pokémon favori'))
          : ListView.builder(
              itemCount: favoritesViewModel.favorites.length,
              itemBuilder: (context, index) {
                final Pokemon pokemon = favoritesViewModel.favorites[index];
                return ListTile(
                  title: Text(pokemon.customName.isNotEmpty
                      ? pokemon.customName
                      : pokemon.name),
                  leading: Image.network(pokemon.imageUrl),
                  onTap: () {
                    Navigator.pushNamed(context, '/details',
                        arguments: pokemon);
                  },
                );
              },
            ),
    );
  }
}
