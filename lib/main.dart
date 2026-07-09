import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'theme/app_colors.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const PortfolioApp());
}

class PortfolioApp extends StatelessWidget {
  const PortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jishnu | Flutter Developer',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: AppColors.background,
        primaryColor: AppColors.primary,
        textTheme: GoogleFonts.outfitTextTheme(ThemeData.dark().textTheme)
            .apply(
              bodyColor: AppColors.textMain,
              displayColor: AppColors.textMain,
            ),
        colorScheme: const ColorScheme.dark(
          primary: AppColors.primary,
          surface: AppColors.lightBackground,
        ),
      ),
      home: const HomeScreen(showEducation: false),
    );
  }
}
