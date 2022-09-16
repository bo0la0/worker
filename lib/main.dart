import 'package:tourist/app.dart';
import 'package:flutter/material.dart';
import 'package:tourist/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:tourist/core/shared/local/cache_helper.dart';
import 'package:tourist/auth/cubit/local_auth/local_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(Tourist(startScreen: await auth()));
}
