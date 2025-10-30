import 'package:hive/hive.dart';

part 'profile_model.g.dart'; // generated file

@HiveType(typeId: 0)
class ProfileModel extends HiveObject {
  @HiveField(0)
  final String firstname;

  @HiveField(1)
  final String surname;

  @HiveField(2)
  final int gestationalAge;

  @HiveField(3)
  final DateTime createdAt;

  // @HiveField(3)
  // final double weight; // in kg

  // @HiveField(4)
  // final double height; // in cm

  ProfileModel({
    required this.firstname,
    required this.surname,
    required this.gestationalAge,
  }): createdAt = DateTime.now();
}