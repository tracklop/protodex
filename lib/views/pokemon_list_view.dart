import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/pokemon_list_viewmodel.dart';
import '../viewmodels/favorites_viewmodel.dart';
import '../viewmodels/captured_viewmodel.dart';
import '../views/favorites_view.dart';
import '../views/captured_view.dart';

class PokemonListView extends StatefulWidget {
  const PokemonListView({super.key});

  @override
  _PokemonListViewState createState() => _PokemonListViewState();
}

class _PokemonListViewState extends State<PokemonListView> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    final viewModel = Provider.of<PokemonListViewModel>(context, listen: false);
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent - 200 &&
          viewModel.hasMore) {
        viewModel.fetchPokemonList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<PokemonListViewModel>(context);
    final favoritesViewModel = Provider.of<FavoritesViewModel>(context);
    final capturedViewModel = Provider.of<CapturedViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
            'Pokédex (${viewModel.pokemonList.length}/${viewModel.totalCount})'),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FavoritesView(),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.catching_pokemon),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CapturedView(),
                ),
              );
            },
          ),
        ],
      ),
      body: viewModel.isLoading && viewModel.pokemonList.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              controller: _scrollController,
              itemCount: viewModel.hasMore
                  ? viewModel.pokemonList.length + 1
                  : viewModel.pokemonList.length,
              itemBuilder: (context, index) {
                if (index == viewModel.pokemonList.length) {
                  return const Center(child: CircularProgressIndicator());
                }
                final pokemonItem = viewModel.pokemonList[index];
                bool isFavorite =
                    favoritesViewModel.isFavoriteById(pokemonItem.id);
                bool isCaptured =
                    capturedViewModel.isCapturedById(pokemonItem.id);

                return ListTile(
                  title: Text(pokemonItem.name),
                  leading: Image.network(pokemonItem.imageUrl),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Checkbox(
                        value: isFavorite,
                        onChanged: (value) {
                          if (value == true) {
                            favoritesViewModel.addFavoriteById(pokemonItem.id);
                          } else {
                            favoritesViewModel
                                .removeFavoriteById(pokemonItem.id);
                          }
                        },
                      ),
                      Checkbox(
                        value: isCaptured,
                        onChanged: (value) {
                          if (value == true) {
                            capturedViewModel.addCapturedById(pokemonItem.id);
                          } else {
                            capturedViewModel
                                .removeCapturedById(pokemonItem.id);
                          }
                        },
                      ),
                    ],
                  ),
                  onTap: () async {
                    final details = await viewModel.apiService
                        .fetchPokemonDetails(pokemonItem.id);
                    Navigator.pushNamed(context, '/details',
                        arguments: details);
                  },
                );
              },
            ),
    );
  }
}
