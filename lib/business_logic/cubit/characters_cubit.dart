import '../../data/model/character.dart';
import '../../data/repository/characters_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'characters_state.dart';

class CharactersCubit extends Cubit<CharactersState> {
  final CharactersRepo charRepo;

  CharactersCubit(this.charRepo) : super(CharactersInitial());

  List<Character> getAllCharacters() {
    List<Character> chars = [];
    charRepo.getAllCharacters().then((characters) {
      emit(CharactersLoaded(characters));
      chars = characters;
    });

    return chars;
  }
}
