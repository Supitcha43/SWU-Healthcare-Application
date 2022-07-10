// ignore_for_file: use_key_in_widget_constructors, prefer_const_declarations, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hospitalapp01/Page/home_screen.dart';
import 'package:hospitalapp01/provider/google_signIn.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

Future main() async {
  Intl.defaultLocale = "th";
  initializeDateFormatting();
  WidgetsFlutterBinding.ensureInitialized();

  await initialization(null);
  await Firebase.initializeApp();

  runApp(MyApp());
}

Future initialization(BuildContext? context) async {
  await Future.delayed(Duration(seconds: 3));
}

class MyApp extends StatelessWidget {
  static final String title = 'MainPage';

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: (context) => GoogleSignInProvider(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: title,
          theme: ThemeData(
              colorScheme: ColorScheme.fromSwatch().copyWith(
            secondary: Color.fromARGB(199, 10, 81, 161), // Your accent color
          )),
          home: HomePage(),
        ),
      );
}
