import 'package:flutter/material.dart';
import '../screens/about/about_screen.dart';
import '../screens/favorites/favorites_screen.dart';
import '../screens/home/home_screen.dart';
import '../screens/main_navigation_screen.dart';
import '../screens/materials/materials_screen.dart';
import '../screens/search/search_screen.dart';
import '../screens/selection/level_selection_screen.dart';
import '../screens/selection/major_selection_screen.dart';
import '../screens/selection/semester_selection_screen.dart';
import '../screens/splash/splash_screen.dart';

class AppRoutes {
  static const String splash = '/';
  static const String mainNav = '/main';
  static const String home = '/home';
  static const String major = '/major';
  static const String level = '/level';
  static const String semester = '/semester';
  static const String materials = '/materials';
  static const String search = '/search';
  static const String favorites = '/favorites';
  static const String about = '/about';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case mainNav:
        return MaterialPageRoute(builder: (_) => const MainNavigationScreen());
      case home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case major:
        return MaterialPageRoute(builder: (_) => const MajorSelectionScreen());
      case level:
        return MaterialPageRoute(builder: (_) => const LevelSelectionScreen());
      case semester:
        return MaterialPageRoute(
            builder: (_) => const SemesterSelectionScreen());
      case materials:
        return MaterialPageRoute(builder: (_) => const MaterialsScreen());
      case search:
        return MaterialPageRoute(builder: (_) => const SearchScreen());
      case favorites:
        return MaterialPageRoute(builder: (_) => const FavoritesScreen());
      case about:
        return MaterialPageRoute(builder: (_) => const AboutScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('الصفحة غير موجودة: ${settings.name}'),
            ),
          ),
        );
    }
  }
}
