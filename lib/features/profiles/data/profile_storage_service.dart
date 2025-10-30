import 'package:hive/hive.dart';
import 'profile_model.dart';

class ProfileStorageService {
  static const String _boxName = 'profilesBox';

  // Open the box
  static Future<Box<ProfileModel>> _openBox() async {
    return await Hive.openBox<ProfileModel>(_boxName);
  }

  // Save a new profile
  static Future<void> saveProfile(ProfileModel profile) async {
    final box = await _openBox();
    await box.add(profile);
  }

  // Get all profiles
  static Future<List<ProfileModel>> getAllProfiles() async {
    final box = await _openBox();
    return box.values.toList();
  }

  // Check if any profile exists
  static Future<bool> hasProfiles() async {
    final box = await _openBox();
    return box.isNotEmpty;
  }

  // Get the first profile (for splash logic)
  static Future<ProfileModel?> getFirstProfile() async {
    final box = await _openBox();
    return box.isNotEmpty ? box.getAt(0) : null;
  }

  // Delete a profile by index
  static Future<void> deleteProfile(int index) async {
    final box = await _openBox();
    if (index >= 0 && index < box.length) {
      await box.deleteAt(index);
    }
  }

  // Get a specific profile by index
  static Future<ProfileModel?> getProfile(int index) async {
    final box = await _openBox();
    return (index >= 0 && index < box.length) ? box.getAt(index) : null;
  }
}
