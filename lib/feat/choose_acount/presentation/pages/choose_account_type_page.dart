import 'package:flutter/material.dart';
import 'package:intern_hup/core/helper/app_router.dart';
import 'package:intern_hup/feat/choose_acount/presentation/widgets/choose_account_type_body.dart';

/// The "Choose Account Type" screen.
///
/// Provides a dark-mode [Scaffold] shell. All UI composition and local state
/// logic live in [ChooseAccountTypeBody].
class ChooseAccountTypePage extends StatelessWidget {
  const ChooseAccountTypePage({super.key});

  /// Route name constant consumed by [AppRouter].
  static const String routeName = AppRouter.chooseAccountTypeRoute;

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      // Dark background matching the card surface tokens in [AccountTypeCard].
      backgroundColor: Color(0xff0F172A),
      body: ChooseAccountTypeBody(),
    );
  }
}
