import 'package:d_view/d_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';

import 'config/session.dart';
import 'firebase_options.dart';
import 'presentation/page/home_page.dart';
import 'presentation/page/login_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: FutureBuilder(
        future: Session.getUser(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return DView.loadingCircle();
          }
          if (snapshot.data == null) return DView.nothing();
          if (snapshot.data!.id == null) return LoginPage();
          return const HomePage();
        },
      ),
    );
  }
}
