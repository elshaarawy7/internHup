import 'package:go_router/go_router.dart';
import 'package:intern_hup/feat/auth/presentation/pages/login_page.dart';
import 'package:intern_hup/feat/auth/presentation/pages/regester_page.dart';
import 'package:intern_hup/feat/choose_acount/presentation/pages/choose_acount_page.dart';
import 'package:intern_hup/feat/student/presentation/pages/choose_track_page.dart';
import 'package:intern_hup/feat/company/presentation/pages/company_register_page.dart';
import 'package:intern_hup/feat/on_bouding/presentation/pages/on_bourding_page.dart';
import 'package:intern_hup/feat/pslash/presentation/pages/spalash_page.dart';
import 'package:intern_hup/feat/rote.dart';
import 'package:intern_hup/feat/student/presentation/pages/home_page_student.dart';
import 'package:intern_hup/feat/student/presentation/pages/profile_page_student.dart';

class AppRouter {
  // ─── Route name constants ─────────────────────────────────────────────────
  static const String slashRoute = '/';
  static const String onBordingRoute = '/onBordingPage';
  static const String loginRoute = '/loginPage';
  static const String regesterRoute = '/regesterPage';
  static const String chooseAccountTypeRoute = '/chooseAccountType';
  static const String companyRegisterRoute = '/companyRegister';
  static const String chooseTrackRoute = "/choose_track";
  static const String homePageStudentRoute = "/home_page_student";
  static const String profilePageStudentRoute = "/profile_page_student";
  static const String rootRouteStudent = "/rootStudent";

  // ─── Router ───────────────────────────────────────────────────────────────
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

      GoRoute(path: loginRoute, builder: (context, state) => const LoginPage()),

      GoRoute(
        path: regesterRoute,
        builder: (context, state) => const RegesterPage(),
      ),

      // ── New routes ──────────────────────────────────────────────────────
    GoRoute(
        path: chooseAccountTypeRoute,
        builder: (context, state) => const ChooseAcountPage(),
      ),

      GoRoute(
        path: homePageStudentRoute,
        builder: (context, state) => const HomePageStudent(),
      ),

      GoRoute(
        path: profilePageStudentRoute,
        builder: (context, state) => const ProfilePageStudent(),
      ),

      GoRoute(
        path: companyRegisterRoute,
        builder: (context, state) => const CompanyRegisterPage(),
      ),

      GoRoute(
        path: chooseTrackRoute,
        builder: (context, state) => const ChooseTrackPage(),
      ),

      GoRoute(
        path: rootRouteStudent,
        builder: (context, state) => RootStudent(),
      ),
    ],
  );
}
