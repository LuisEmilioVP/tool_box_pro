import 'package:flutter/material.dart';
import 'package:tool_box_pro/utils/styles.dart';
import 'package:tool_box_pro/pages/home_page.dart';
import 'package:tool_box_pro/pages/gender_page.dart';
import 'package:tool_box_pro/pages/age_page.dart';
import 'package:tool_box_pro/pages/universities_page.dart';
import 'package:tool_box_pro/pages/weather_page.dart';
import 'package:tool_box_pro/pages/posts_page.dart';
import 'package:tool_box_pro/pages/about_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Caja de Herramientas',
      theme: ThemeData(
        primaryColor: primaryColor,
        scaffoldBackgroundColor: backgroundColor,
        textTheme: const TextTheme(
          headlineLarge: titleStyle,
          bodyMedium: subtitleStyle,
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        '/gender': (context) => const GenderPage(),
        '/age': (context) => const AgePage(),
        '/universities': (context) => const UniversitiesPage(),
        '/weather': (context) => const WeatherPage(),
        '/posts': (context) => const PostsPage(),
        '/about': (context) => const AboutPage(),
      },
    );
  }
}
