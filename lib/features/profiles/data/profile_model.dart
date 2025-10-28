import 'package:hive/hive.dart';

part 'profile_model.g.dart'; // generated file

@HiveType(typeId: 0)
class ProfileModel extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final DateTime dateOfBirth;

  @HiveField(3)
  final double weight; // in kg

  @HiveField(4)
  final double height; // in cm

  ProfileModel({
    required this.id,
    required this.name,
    required this.dateOfBirth,
    required this.weight,
    required this.height,
  });
}