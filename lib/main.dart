import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'app.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'features/profiles/data/profile_model.dart';

Future <void> main() async{
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  if(!Hive.isAdapterRegistered(ProfileModelAdapter().typeId)){
    Hive.registerAdapter(ProfileModelAdapter());
  }

  runApp(const ProviderScope(child: SleepApneaApp()));

}
