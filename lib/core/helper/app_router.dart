import 'package:go_router/go_router.dart';
import 'package:intern_hup/feat/auth/presentation/pages/login_page.dart';
import 'package:intern_hup/feat/auth/presentation/pages/regester_page.dart';
import 'package:intern_hup/feat/on_bouding/presentation/pages/on_bourding_page.dart';
import 'package:intern_hup/feat/pslash/presentation/pages/spalash_page.dart';

class AppRouter {
  static const String slashRoute = '/';
  static const String onBordingRoute = '/onBordingPage';
  static const String loginRoute = '/loginPage';
  static const String regesterRoute = '/regesterPage';

  static final router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: slashRoute,
        builder: (context, state) => const SpalashPage(),
      ),

      GoRoute(
        path: onBordingRoute,
        builder: (context, state) => const OnBordingPage(),
      ),

      GoRoute(
        path: loginRoute,
        builder: (context, state) => const LoginPage(),
      ),

      GoRoute(
        path: regesterRoute,
        builder: (context, state) => const RegesterPage(),
      ),
    ],
  );
}