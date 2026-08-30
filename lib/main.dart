import 'package:flutter/material.dart';
import 'package:intern_hup/core/constant/app_color.dart';
import 'package:intern_hup/core/constant/app_constant.dart';
import 'package:intern_hup/core/helper/app_router.dart';
import 'package:intern_hup/core/services/getit.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: AppConstant.supabaseUrl,
    anonKey: AppConstant.subabaseAnonKay,
  );
  setupGetIt();
  runApp(const InternHupApp());
}

class InternHupApp extends StatelessWidget {
  const InternHupApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primColor),
      ),
      debugShowCheckedModeBanner: false,
      routerConfig: AppRouter.router,
    );
  }
}
