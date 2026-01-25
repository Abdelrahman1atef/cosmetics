import 'package:cosmetics/views/splash.dart';
import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';


void main() {
  runApp(DevicePreview(enabled: false, builder: (context) => const AvonApp()));
}

class AvonApp extends StatelessWidget {
  const AvonApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const SplashView(),
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: "Montserrat",
        textTheme: const TextTheme(
          titleLarge: TextStyle(
            fontFamily: 'Montserrat',
            fontSize: 40,
            color: Color(0xFF434C6D),
            fontVariations: <FontVariation>[FontVariation('wght', 700)],
          ),
          titleMedium: TextStyle(
            fontFamily: 'Montserrat',
            fontSize: 18,
            color: Color(0xFF8E8EA9),
            fontVariations: <FontVariation>[FontVariation('wght', 400)],
          ),
          titleSmall: TextStyle(
            fontFamily: 'Montserrat',
            fontSize: 15,
            color: Color(0xFF8E8EA9),
            fontVariations: <FontVariation>[FontVariation('wght', 500)],
          ),
          headlineMedium: TextStyle(
            fontFamily: 'Montserrat',
            fontSize: 18,
            fontVariations: <FontVariation>[FontVariation('wght', 700)],
            color: Color(0xFF62322D),
          ),
          displayLarge: TextStyle(
            fontFamily: 'Montserrat',
            fontSize: 20,
            color: Color(0xFF434C6D),
            fontVariations: <FontVariation>[FontVariation('wght', 700)],
          ),
          displayMedium: TextStyle(
            fontFamily: 'Montserrat',
            fontSize: 18,
            color: Color(0xFF434C6D),
            fontVariations: <FontVariation>[FontVariation('wght', 600)],
          ),
          displaySmall: TextStyle(
            fontFamily: 'Montserrat',
            fontSize: 14,
            color: Color(0xFFCD0F0F),
            fontVariations: <FontVariation>[FontVariation('wght', 600)],
          ),
          bodyMedium: TextStyle(fontFamily: 'Segoe', fontSize: 18, fontWeight: FontWeight.w600, color: Colors.white),
          labelMedium: TextStyle(
            fontFamily: 'Montserrat',
            fontSize: 18,
            fontVariations: <FontVariation>[FontVariation('wght', 600)],
            color: Color(0xFFD75D72),
          ),
        ),
        useSystemColors: true,
        hintColor: const Color(0xFF8E8EA9),
        scaffoldBackgroundColor: const Color(0xFFD9D9D9),
        colorScheme: const ColorScheme(
          brightness: Brightness.light,
          primary: Color(0xFFD75D72),
          onPrimary: Color(0xFFD75D72),
          secondary: Color(0xFF434C6D),
          onSecondary: Color(0xFF434C6D),
          error: Color(0xFFCD0F0F),
          onError: Color(0xFFCD0F0F),
          surface: Color(0xFFB3B3C1),
          onSurface: Color(0xFFB3B3C1),
        ),
        searchBarTheme: const SearchBarThemeData(
          elevation: WidgetStatePropertyAll(0),
          padding: WidgetStatePropertyAll(EdgeInsetsDirectional.symmetric(horizontal: 15, vertical: 5)),
          side: WidgetStatePropertyAll(BorderSide(color: Color(0xFFB3B3C1), width: 1)),
          backgroundColor: WidgetStatePropertyAll(Color(0xFFD9D9D9)),
        ),
        inputDecorationTheme: InputDecorationThemeData(
          // labelStyle: TextTheme.of(context).titleMedium,
          // floatingLabelStyle: TextTheme.of(context).titleMedium?.copyWith(fontSize: 25),
          focusedBorder: OutlineInputBorder(
            gapPadding: 16,
            borderRadius: BorderRadius.circular(13),
            borderSide: BorderSide(color: Theme.of(context).hintColor, width: 2),
          ),
          enabledBorder: OutlineInputBorder(
            gapPadding: 16,
            borderRadius: BorderRadius.circular(13),
            borderSide: BorderSide(color: Theme.of(context).hintColor, width: 2),
          ),
        ),
      ),
    );
  }
}
