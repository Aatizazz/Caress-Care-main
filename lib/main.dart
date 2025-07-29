import 'package:caress_care/firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:get/get.dart';
import 'routes/app_routes.dart';
import 'package:provider/provider.dart';
import 'controller/profile_ctrls.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // ---- Firebase Init ----
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // ---- Hive Init ----
  await Hive.initFlutter();
  await Hive.openBox('journals');

  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => ProfileController())],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calm Zone',
      initialRoute: AppRoutes.splash,
      getPages: AppRoutes.routes,
    );
  }
}
