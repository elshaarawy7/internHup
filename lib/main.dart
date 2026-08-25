import 'package:flutter/material.dart';
import 'package:intern_hup/core/helper/app_router.dart';
import 'package:intern_hup/feat/pslash/presentation/pages/spalash_page.dart';

void main() {
  runApp(const InternHupApp());
}

class InternHupApp extends StatelessWidget {
  const InternHupApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: SpalashPage());
  }
}
