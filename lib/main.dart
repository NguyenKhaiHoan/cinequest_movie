import 'package:cinequest/cinequest_movie.dart';
import 'package:cinequest/src/core/di/injection_container.import.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  await initApp();
  runApp(const CineQuestMovie());
}
