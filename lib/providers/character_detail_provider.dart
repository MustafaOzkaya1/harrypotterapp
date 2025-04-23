import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:harrypotterapp/core/services/service.dart';
import 'package:harrypotterapp/models/character_model.dart';

// Karakteri ID'ye göre almak için FutureProvider
final characterDetailProvider = FutureProvider.family<CharacterModel, String>((ref, characterId) async {
  final service = Service();
  return service.getCharacterById(characterId);  // 'getCharacterById' metodu ile veriyi alıyoruz
});
