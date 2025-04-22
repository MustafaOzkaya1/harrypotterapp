import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:harrypotterapp/core/services/service.dart';
import 'package:harrypotterapp/models/character_model.dart';

final characterProvider = FutureProvider<List<CharacterModel>>((ref) async {
  final service = Service();
  return service.getCharacterInfo();
});
