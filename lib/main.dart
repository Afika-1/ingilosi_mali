
import 'package:flutter/material.dart';
import 'package:ingilosi_mali/screens/welcome_screen.dart';

// import 'package:corpnet_flut/screens/welcome_screen.dart';
// import 'package:corpnet_flut/widgets/splash_screen.dart';

// import 'screens/home_screen.dart';
// import 'screens/network_page.dart';
// import 'screens/post_screen.dart';
// import 'screens/business_page.dart';
// import 'screens/profile_screen.dart';


void main() {
  runApp(IngilosiMaliApp());
}

class IngilosiMaliApp extends StatelessWidget {
  const IngilosiMaliApp({super.key});

  @override
  Widget build(BuildContext context) {
    final Color maroonPrimary = Color(0xFFDC2626);
    final Color maroonAccent = Color(0xFF7F1D1D);
    final Color darkBackground = Color(0xFF111827);
    final Color darkGreyBackground = Color(0xFF1F2937);

    return MaterialApp(
      title: 'CorpNet',
      theme: ThemeData(
        fontFamily: 'Agrandir',
        useMaterial3: true,
        colorScheme: ColorScheme(
          primary: maroonPrimary,
          primaryContainer: maroonAccent,
          secondary: maroonAccent,
          secondaryContainer: maroonPrimary,
          surface: darkGreyBackground,
          error: Colors.red.shade700,
          onPrimary: Colors.white,
          onSecondary: Colors.white,
          onSurface: Colors.white,
          onError: Colors.white,
          brightness: Brightness.dark,
        
        ),
        scaffoldBackgroundColor: darkBackground,
        appBarTheme: AppBarTheme(
          backgroundColor: maroonPrimary,
          foregroundColor: Colors.white,
          titleTextStyle: TextStyle(
            fontFamily: 'Agrandir',
            fontWeight: FontWeight.w600,
            fontSize: 20,
            color: Colors.white,
          ),
          iconTheme: IconThemeData(color: Colors.white),
          elevation: 0,
        ),
        textTheme: TextTheme(
          titleLarge: TextStyle(color: Colors.white, fontSize: 20),
          bodyLarge: TextStyle(color: Colors.white, fontSize: 14),
          bodyMedium: TextStyle(color: Colors.white70, fontSize: 12),
          labelLarge: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
        iconTheme: IconThemeData(color: Colors.white),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: darkGreyBackground,
          labelStyle: TextStyle(color: Colors.white70),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: maroonAccent),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: maroonPrimary),
          ),
        ),
        buttonTheme: ButtonThemeData(
          buttonColor: maroonPrimary,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          textTheme: ButtonTextTheme.primary,
        ),
      ),
      // initialRoute: '/',
      routes: {
        // '/home': (context) => HomeScreen(),
        // '/network': (context) => NetworkScreen(),
        // '/post': (context) => CreatePostScreen(),
        // '/business': (context) => BusinessScreen(),
        // '/profile': (context) => ProfileScreen(),
      },
      home: WelcomeScreen(),
      //
    );
  }
}