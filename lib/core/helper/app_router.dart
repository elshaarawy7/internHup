import 'package:go_router/go_router.dart';
import 'package:intern_hup/feat/pslash/presentation/pages/spalash_page.dart';

class AppRouter {
  
  
  
  static const String slashRoute = "/";
  

  static final router = GoRouter(
    initialLocation: '/',
    routes: [
    
      GoRoute(
        path: slashRoute,
        builder: (context, state) => const SpalashPage(),
      ),
    ],
  );
}