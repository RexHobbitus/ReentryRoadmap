import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'core/routes/app_router.dart';
import 'firebase_options.dart';
import 'main_app.dart';
import 'service_locator/service_locator.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await ServiceLocator.initialize();
  AppRouter.initialize();
  runApp(const MainApp());
}
