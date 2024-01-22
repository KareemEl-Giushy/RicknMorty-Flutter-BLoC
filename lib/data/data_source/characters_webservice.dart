import 'dart:io';

import '../../config/constaints/constaints.dart';
import 'package:dio/dio.dart';

class CharactersWebServices {
  final BaseOptions _options = BaseOptions(
    baseUrl: baseUrl,
    receiveDataWhenStatusError: true,
  );
  late Dio _dio;

  CharactersWebServices() {
    _dio = Dio(_options);
  }

  Future<List<dynamic>> getAllCharacters() async {
    try {
      Response response = await _dio.get("character");

      if (response.statusCode == HttpStatus.ok) {
        print(response.data);
        print(response.data.toString());
        return response.data['results'];
      }
    } catch (e) {
      print(e.toString());
    }

    return [];
  }
}
