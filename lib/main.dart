import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'initial_page.dart';
import 'provider/email_sign_in_provider.dart';
import 'provider/google_sign_in_provider.dart';
import 'provider/theme_provider.dart';
import 'utility/constant.dart';
import 'utility/theme_data.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => ThemeProvider()),
        ChangeNotifierProvider(create: (ctx) => GoogleSignInProvider()),
        ChangeNotifierProvider(create: (ctx) => EmailSignInProvider()),
      ],
      builder: (context, _) {
        final themeProvider = Provider.of<ThemeProvider>(context);
        return MaterialApp(
          title: kApptitle,
          debugShowCheckedModeBanner: false,
          themeMode: themeProvider.themeMode,
          theme: MyThemeData.lightTheme,
          darkTheme: MyThemeData.darkTheme,
          initialRoute: '/',
          routes: {
            '/': (ctx) => const InitialPage(),
            // '/ProductOverviewScreen': (context) => const ProductOverviewScreen(),
            // '/ProductDetailScreen': (context) => const ProductDetailScreen(),
          },
        );
      },
    );
  }
}
