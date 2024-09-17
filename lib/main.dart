import 'package:cinequest/my_app.dart';
import 'package:flutter/material.dart';

import 'src/core/injection_container.dart';

Future<void> main() async {
  await initDependencies();
  runApp(const MyApp());
}
