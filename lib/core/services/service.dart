import 'dart:io';
import 'package:dio/dio.dart';
import 'package:harrypotterapp/models/character_model.dart';
import 'package:harrypotterapp/core/utils/constants.dart';

class Service {
  final Dio dio = Dio();
  final String urlcharacter = url; // URL'nizi doğru şekilde alıyoruz.

  Future<List<CharacterModel>> getCharacterInfo() async {
    List<CharacterModel> characters = [];
    
    try {
      final response = await dio.get(urlcharacter);

      // HTTP Status kodunu kontrol ediyoruz.
      if (response.statusCode == HttpStatus.ok) {
        // JSON'dan listeyi oluşturuyoruz
        final responseData = response.data as List;
        characters = responseData.map((e) => CharacterModel.fromJson(e)).toList();
      } else {
        // StatusCode başarılı değilse, hata mesajı döndürüyoruz.
        print('Failed to load characters. Status Code: ${response.statusCode}');
      }
    } on DioError catch (e) {
      // DioError: HTTP bağlantı hataları veya başka ağ hataları
      print('DioError: ${e.message}');
    } catch (e) {
      // Genel hata yakalama
      print('An unexpected error occurred: $e');
    }

    return characters;
  }
}
