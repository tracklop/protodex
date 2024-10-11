import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/pokemon_list_viewmodel.dart';

class PokemonListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<PokemonListViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Pokédex'),
        actions: [
          IconButton(
            icon: Icon(Icons.favorite),
            onPressed: () {
              Navigator.pushNamed(context, '/favorites');
            },
          ),
        ],
      ),
      body: viewModel.isLoading
          ? Center(child: CircularProgressIndicator())
          : viewModel.errorMessage.isNotEmpty
              ? Center(child: Text(viewModel.errorMessage))
              : ListView.builder(
                  itemCount: viewModel.pokemonList.length,
                  itemBuilder: (context, index) {
                    final pokemon = viewModel.pokemonList[index];
                    return ListTile(
                      title: Text(pokemon.name),
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
