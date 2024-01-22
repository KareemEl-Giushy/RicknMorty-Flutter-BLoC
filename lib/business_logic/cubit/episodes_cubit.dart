import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/model/character.dart';
import '../../data/model/episode.dart';
import '../../data/repository/episodes_repo.dart';

import 'episodes_state.dart';

class EpisodesCubit extends Cubit<EpisodesState> {
  final EpisodesRepo _episodesRepo;

  EpisodesCubit(this._episodesRepo) : super(EpisodesInitial());

  List<Episode> getCharacterEpisodes(Character char) {
    List<Episode> epis = [];
    emit(EpisodesLoading());
    _episodesRepo.getCharacterEpisodes(char).then((episodes) {
      emit(EpisodesLoaded(episodes));
      epis = episodes;
    });

    return epis;
  }
}
