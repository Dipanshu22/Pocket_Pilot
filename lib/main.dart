import 'package:flutter/material.dart';

//import 'package:flutter/services.dart';

import 'package:pocket_pilot/mywidget/expenses.dart';

var kColorScheme = ColorScheme.fromSeed(
  seedColor:const  Color.fromARGB(138, 176, 140, 186),
);

var kDarkColorScheme =ColorScheme.fromSeed(
  brightness: Brightness.dark,
  seedColor: const Color.fromARGB(255, 5, 99, 125),
);

void main() {
  //WidgetsFlutterBinding.ensureInitialized();
  //SystemChrome.setPreferredOrientations([
  // DeviceOrientation.portraitUp,
  //]).then((func){
     runApp(
    MaterialApp(
      darkTheme: ThemeData.dark().copyWith(
         useMaterial3: true,
         colorScheme: kDarkColorScheme,
         appBarTheme: const AppBarTheme().copyWith(
          backgroundColor: kDarkColorScheme.onPrimaryContainer,
          foregroundColor: kDarkColorScheme.primaryContainer,
        ),
          cardTheme: const CardTheme().copyWith(
          color: kDarkColorScheme.secondaryContainer,
          margin: const EdgeInsets.all(10),
        ),
         elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: kDarkColorScheme.secondaryContainer,
            foregroundColor: kDarkColorScheme.onSecondaryContainer,
          ),
        ),
      ),

      theme: ThemeData().copyWith(
        useMaterial3: true,
        //scaffoldBackgroundColor: Color.fromARGB(159, 180, 135, 51)),
        colorScheme: kColorScheme,
        appBarTheme: const AppBarTheme().copyWith(
          backgroundColor: kColorScheme.onPrimaryContainer,
          foregroundColor: kColorScheme.primaryContainer,
        ),
        cardTheme: const CardTheme().copyWith(
          color: kColorScheme.secondaryContainer,
          margin: const EdgeInsets.all(10),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: kColorScheme.secondaryContainer,
            foregroundColor: kColorScheme.onSecondaryContainer,
          ),
        ),
        textTheme: ThemeData().textTheme.copyWith(
              titleLarge: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: kColorScheme.onPrimaryContainer,
                  fontSize: 16,
                  ),
            ),
      ),
      // themeMode: ThemeMode.system,  Default
      home: const Expenses(),
    ),
  );
//});
}
  
