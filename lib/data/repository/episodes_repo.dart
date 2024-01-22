import '../data_source/episodes_webservice.dart';
import '../model/character.dart';
import '../model/episode.dart';

class EpisodesRepo {
  final EpisodesWebService _episodeWebService;

  EpisodesRepo(this._episodeWebService);

  Future<List<Episode>> getCharacterEpisodes(Character char) async {
    List<Episode> episodes = [];
    for (var ep in char.episodes) {
      int id = int.parse(ep.substring(ep.lastIndexOf("/") + 1));
      // print(id);
      Episode? episode = await _episodeWebService.getEpisode(id);

      if (episode != null) {
        episodes.add(episode);
      }
    }

    return episodes;
  }
}
