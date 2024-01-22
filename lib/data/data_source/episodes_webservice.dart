import 'dart:io';

import 'package:dio/dio.dart';
import '../../config/constaints/constaints.dart';
import '../model/episode.dart';

class EpisodesWebService {
  final BaseOptions _baseOptions = BaseOptions(
    baseUrl: baseUrl,
    receiveDataWhenStatusError: true,
  );

  late Dio _dio;

  EpisodesWebService() {
    _dio = Dio(_baseOptions);
  }

  Future<Episode?> getEpisode(id) async {
    try {
      Response reponse = await _dio.get("episode/$id");

      if (reponse.statusCode == HttpStatus.ok) {
        return Episode.fromJson(reponse.data);
      }
    } catch (e) {
      print(e);
    }

    return null;
  }
}
