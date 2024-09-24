import 'package:cinequest/cinequest_movie.dart';
import 'package:flutter/material.dart';

import 'src/core/injection_container.dart';

Future<void> main() async {
  await initApp();
  runApp(const CineQuestMovie());
}
