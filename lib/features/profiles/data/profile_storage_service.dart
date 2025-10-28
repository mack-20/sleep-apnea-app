import 'package:hive/hive.dart';
import 'profile_model.dart';

class ProfileStorageService {
  static const _boxName = 'profiles';

  late Box<ProfileModel> _box;

  Future<void> init() async {
    _box = await Hive.openBox<ProfileModel>(_boxName);
  }

  Future<void> addProfile(ProfileModel profile) async {
    await _box.add(profile);
  }

  List<ProfileModel> getAllProfiles() {
    return _box.values.toList();
  }

  bool hasProfiles() {
    return _box.isNotEmpty;
  }

  Future<void> clearAllProfiles() async {
    await _box.clear();
  }
}
