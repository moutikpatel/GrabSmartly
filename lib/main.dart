import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grabsmartly/firebase_options.dart';
import 'package:grabsmartly/src/localization/user_provider.dart';
import 'package:grabsmartly/src/repository/authentication/authentication_repository.dart';
import 'package:grabsmartly/src/utils/theme/theme.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform).then(
          (value) => Get.put(AuthenticationRepository())
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserIdProvider()),
        // Note: AuthenticationRepository doesn't extend ChangeNotifier,
        // so we don't include it in ChangeNotifierProvider.
        // Instead, we'll use GetBuilder or Obx to listen for changes.
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      //System Theme
      themeMode: ThemeMode.system,
      theme: TAppTheme.lightTheme,
      darkTheme: TAppTheme.darkTheme,
      debugShowCheckedModeBanner: false,
      //Screen Transitions
      defaultTransition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 1500),
      home: const CircularProgressIndicator(),
      //home: SplashScreen(),

    );
  }

}

