import '../data_source/characters_webservice.dart';
import '../model/character.dart';

class CharactersRepo {
  final CharactersWebServices chars;

  CharactersRepo(this.chars);

  Future<List<Character>> getAllCharacters() async {
    final characters = await chars.getAllCharacters();

    return characters.map((c) => Character.fromJson(c)).toList();
  }
}
