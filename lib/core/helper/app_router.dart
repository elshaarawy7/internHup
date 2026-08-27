import 'package:go_router/go_router.dart';
import 'package:intern_hup/feat/choose_acount/presentation/pages/choose_account_type_page.dart';
import 'package:intern_hup/feat/auth/presentation/pages/login_page.dart';
import 'package:intern_hup/feat/auth/presentation/pages/regester_page.dart';
import 'package:intern_hup/feat/company/presentation/pages/company_register_page.dart';
import 'package:intern_hup/feat/on_bouding/presentation/pages/on_bourding_page.dart';
import 'package:intern_hup/feat/pslash/presentation/pages/spalash_page.dart';
import 'package:intern_hup/feat/student/presentation/pages/student_register_page.dart';

class AppRouter {
  // ─── Route name constants ─────────────────────────────────────────────────
  static const String slashRoute = '/';
  static const String onBordingRoute = '/onBordingPage';
  static const String loginRoute = '/loginPage';
  static const String regesterRoute = '/regesterPage'; 

  static const String chooseAccountTypeRoute = '/chooseAccountType';

  /// Student registration form screen.
  static const String studentRegisterRoute = '/studentRegister';

  /// Company registration form screen.
  static const String companyRegisterRoute = '/companyRegister';

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

      GoRoute(
        path: loginRoute,
        builder: (context, state) => const LoginPage(),
      ),

      GoRoute(
        path: regesterRoute,
        builder: (context, state) => const RegesterPage(),
      ),

      // ── New routes ──────────────────────────────────────────────────────
      GoRoute(
        path: chooseAccountTypeRoute,
        builder: (context, state) => const ChooseAccountTypePage(),
      ),

      GoRoute(
        path: studentRegisterRoute,
        builder: (context, state) => const StudentRegisterPage(),
      ),

      GoRoute(
        path: companyRegisterRoute,
        builder: (context, state) => const CompanyRegisterPage(),
      ),
    ],
  );
}