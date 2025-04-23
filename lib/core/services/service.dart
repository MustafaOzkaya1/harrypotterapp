import 'dart:io';
import 'package:dio/dio.dart';
import 'package:harrypotterapp/models/character_model.dart';
import 'package:harrypotterapp/core/utils/constants.dart';

class Service {
  final Dio dio = Dio();
  final String urlcharacter = url; // URL'nizi doğru şekilde alıyoruz.

  // Tüm karakterleri alıyoruz
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
        print('karakter yüklenirken bir hata oluştu: ${response.statusCode}');
      }
    } on DioError catch (e) {
      // DioError: HTTP bağlantı hataları veya başka ağ hataları
      print('DioError: ${e.message}');
    } catch (e) {
      // Genel hata yakalama
      print('Hata: $e');
    }

    return characters;
  }

  // Belirli bir ID ile karakteri alıyoruz
  Future<CharacterModel> getCharacterById(String id) async {
    CharacterModel character;

    try {
      final response = await dio.get('$urlcharacter/$id');  // ID ile URL'yi tamamlıyoruz

      // HTTP Status kodunu kontrol ediyoruz.
      if (response.statusCode == HttpStatus.ok) {
        // JSON'dan karakteri oluşturuyoruz
        character = CharacterModel.fromJson(response.data);
      } else {
        // StatusCode başarılı değilse, hata mesajı döndürüyoruz.
        print('karakter yüklenirken bir hata oluştu: ${response.statusCode}');
        character = CharacterModel.empty();  // Hata durumunda boş bir karakter dönüyoruz
      }
    } on DioError catch (e) {
      // DioError: HTTP bağlantı hataları veya başka ağ hataları
      print('DioError: ${e.message}');
      character = CharacterModel.empty();  // Hata durumunda boş bir karakter dönüyoruz
    } catch (e) {
      // Genel hata yakalama
      print('Hata: $e');
      character = CharacterModel.empty();  // Hata durumunda boş bir karakter dönüyoruz
    }

    return character;
  }
}
