import 'business_logic/cubit/characters_cubit.dart';
import 'business_logic/cubit/episodes_cubit.dart';
import 'data/data_source/characters_webservice.dart';
import 'data/data_source/episodes_webservice.dart';
import 'data/model/character.dart';
import 'data/repository/characters_repo.dart';
import 'data/repository/episodes_repo.dart';
import 'persentation/screens/character_details.dart';
import 'persentation/screens/characters_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyRoutes {
  static const charactersScreen = "/";
  static const characterDetailsScreen = "/character_details";
}

class AppRouter {
  late CharactersRepo _charRepo;
  late CharactersCubit _charCubit;

  late EpisodesCubit _episodesCubit;

  AppRouter() {
    _charRepo = CharactersRepo(CharactersWebServices());
    _charCubit = CharactersCubit(_charRepo);

    _episodesCubit = EpisodesCubit(EpisodesRepo(EpisodesWebService()));
  }

  Route<MaterialPageRoute>? generateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case MyRoutes.charactersScreen:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => _charCubit,
            child: const CharactersScreen(),
          ),
        );

      case MyRoutes.characterDetailsScreen:
        final selectedChar = settings.arguments as Character;
        return MaterialPageRoute(
          builder: (context) => BlocProvider.value(
            value: _episodesCubit,
            child: CharacterDetailsScreen(character: selectedChar),
          ),
        );
    }

    return null;
  }
}
