import 'package:com_noopeshop_app/models/system_model.dart';
import 'package:hive/hive.dart';

class SystemRepository {
  late Box<dynamic> _system;

  Future<SystemModel> init() async {
    _system = await Hive.openBox('system');

    return system;
  }

  Future<void> reset() async {
    await _system.deleteFromDisk();
  }

  SystemModel get system => SystemModel(
        hasSwipe: _system.get('swipe') ?? false,
        hasAddToFavorites: _system.get('favorites') ?? false,
      );

  bool hasSwipe() {
    return _system.get('swipe') ?? false;
  }

  bool hasAddToFavorites() {
    return _system.get('favorites') ?? false;
  }

  Future<SystemModel> updateSwipe(bool value) async {
    await _system.put('swipe', value);

    return system;
  }

  Future<SystemModel> updateFavorite(bool value) async {
    await _system.put('favorites', value);

    return system;
  }
}
