import 'package:cinequest/cinequest_movie.dart';
import 'package:cinequest/firebase_options.dart';
import 'package:cinequest/src/core/di/injection_container.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await initDependencies();
  runApp(const CineQuestMovie());
}
