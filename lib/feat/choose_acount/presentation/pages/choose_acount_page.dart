import 'package:flutter/cupertino.dart';
import 'package:intern_hup/feat/choose_acount/presentation/widgets/choose_acount_page_body.dart';

class ChooseAcountPage extends StatelessWidget {
  const ChooseAcountPage({super.key});

  static const String chooseAcountRoute = "/choose_acount";

  @override
  Widget build(BuildContext context) {
    return ChooseAcountPageBody();
  }
}