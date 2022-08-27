import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tutor_admin/firebase_options.dart';
import 'package:tutor_admin/root.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:tutor_admin/src/providers/user_provider.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  widgetsBinding;

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(
        create: (context) => UserProvider(),
      )
    ], child: const MyApp()),
  );

  FlutterNativeSplash.remove();
}
