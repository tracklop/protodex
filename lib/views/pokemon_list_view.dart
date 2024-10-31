import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/pokemon_list_viewmodel.dart';
import '../viewmodels/favorites_viewmodel.dart';
import '../viewmodels/captured_viewmodel.dart';
import '../views/favorites_view.dart';
import '../views/captured_view.dart';
import '../utils/color_utils.dart';

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

                return Container(
                  margin: const EdgeInsets.all(5.0),
                  padding: const EdgeInsets.all(15.0),
                  decoration: BoxDecoration(
                    gradient: pokemonItem.types.length > 1
                        ? LinearGradient(
                            begin: Alignment.bottomLeft,
                            end: Alignment.topRight,
                            colors: [
                                getColorForType(pokemonItem.types[0]),
                                getColorForType(pokemonItem.types[1]),
                              ],
                            stops: [
                                0.25,
                                0.75
                              ])
                        : null,
                    color: pokemonItem.types.length == 1
                        ? getColorForType(pokemonItem.types[0])
                        : null,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListTile(
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          pokemonItem.name,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: pokemonItem.types.map((type) {
                            return Container(
                              padding: const EdgeInsets.symmetric(
                                vertical: 4,
                                horizontal: 8,
                              ),
                              margin: const EdgeInsets.only(right: 4),
                              decoration: BoxDecoration(
                                color: getColorForType(type),
                                borderRadius: BorderRadius.circular(8),
                                border:
                                    Border.all(color: Colors.white, width: 1),
                              ),
                              child: Text(
                                type.toUpperCase(),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                    leading: Image.network(pokemonItem.imageUrl),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Icône pour Favori
                        IconButton(
                          icon: Icon(
                            isFavorite ? Icons.star : Icons.star_border,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            setState(() {
                              if (isFavorite) {
                                favoritesViewModel
                                    .removeFavoriteById(pokemonItem.id);
                              } else {
                                favoritesViewModel
                                    .addFavoriteById(pokemonItem.id);
                              }
                            });
                          },
                        ),
                        // Icône pour Capturé
                        IconButton(
                          icon: Icon(
                            isCaptured
                                ? Icons.catching_pokemon
                                : Icons.catching_pokemon_outlined,
                            color: isCaptured ? Colors.red : Colors.white,
                          ),
                          onPressed: () {
                            setState(() {
                              if (isCaptured) {
                                capturedViewModel
                                    .removeCapturedById(pokemonItem.id);
                              } else {
                                capturedViewModel
                                    .addCapturedById(pokemonItem.id);
                              }
                            });
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
                  ),
                );
              },
            ),
    );
  }
}
