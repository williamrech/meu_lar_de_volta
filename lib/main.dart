import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'config/app_colors.dart';
import 'pages/home/home_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      authDomain: 'meu-lar-de-volta.firebaseapp.com',
      apiKey: 'AIzaSyCjlR2dnSUgNVi4DSIeZ1lMIg6Sw0GtKH0',
      appId: '1:71058515420:web:0138ee9a5cb76568ec1b19',
      messagingSenderId: '71058515420',
      projectId: 'meu-lar-de-volta',
      storageBucket: 'meu-lar-de-volta.appspot.com',
      measurementId: 'G-Q0DXQELWSW',
    ),
  );

  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}
