import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'viewmodels/pokemon_list_viewmodel.dart';
import 'viewmodels/favorites_viewmodel.dart';
import 'viewmodels/captured_viewmodel.dart';
import 'viewmodels/total_count_viewmodel.dart';
import 'views/pokemon_list_view.dart';
import 'views/pokemon_detail_view.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => PokemonListViewModel(),
        ),
        ChangeNotifierProvider(
          create: (_) => FavoritesViewModel(),
        ),
        ChangeNotifierProvider(
          create: (_) => CapturedViewModel(),
        ),
        ChangeNotifierProvider(
          create: (_) => TotalCountViewModel(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pokédex',
      initialRoute: '/',
      routes: {
        '/': (context) => const PokemonListView(),
        '/details': (context) => const PokemonDetailView(),
      },
    );
  }
}
