import '../../data/model/episode.dart';
import 'package:flutter/material.dart';

@immutable
abstract class EpisodesState {}

class EpisodesInitial extends EpisodesState {}

class EpisodesLoading extends EpisodesState {}

class EpisodesLoaded extends EpisodesState {
  final List<Episode> episodes;

  EpisodesLoaded(this.episodes);
}
