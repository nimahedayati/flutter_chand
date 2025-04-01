import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'screens/currency_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Currency Tracker',
      scrollBehavior: ScrollConfiguration.of(context).copyWith(
        dragDevices: {
          PointerDeviceKind.touch,
          PointerDeviceKind.mouse,
          PointerDeviceKind.trackpad,
        },
      ),
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData(
        appBarTheme: AppBarTheme(
          centerTitle: true,
          titleTextStyle:
              GoogleFonts.nunito(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        brightness: Brightness.dark,
        useMaterial3: true,
        textTheme: GoogleFonts.nunitoTextTheme(Typography().white),
        colorScheme: ColorScheme.fromSeed(
          surface: Colors.black,
          seedColor: Colors.white,
          brightness: Brightness.dark,
        ),
      ),
      home: const CurrencyScreen(),
    );
  }
}
