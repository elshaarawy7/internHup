import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intern_hup/feat/auth/presentation/pages/choose_account_type_page.dart';
import 'package:intern_hup/feat/auth/presentation/pages/login_page.dart';
import 'package:intern_hup/feat/auth/presentation/pages/regester_page.dart';
import 'package:intern_hup/feat/company/presentation/pages/applecation_page.dart';
import 'package:intern_hup/feat/company/presentation/pages/intern_ship_page.dart';
import 'package:intern_hup/feat/company/presentation/pages/jop_detils_page.dart';
import 'package:intern_hup/feat/company/presentation/pages/profile_company_page.dart';
import 'package:intern_hup/feat/on_bouding/presentation/pages/on_bourding_page.dart';
import 'package:intern_hup/feat/pslash/presentation/pages/spalash_page.dart';
import 'package:intern_hup/feat/student/presentation/pages/choose_track_page.dart';
import 'package:intern_hup/feat/student/presentation/pages/home_page_student.dart';
import 'package:intern_hup/feat/student/presentation/pages/profile_page_student.dart';
import 'package:intern_hup/feat/internships/domain/entities/internship_entity.dart';
import 'package:intern_hup/feat/internships/domain/entities/internship_application_entity.dart';
import 'package:intern_hup/feat/internships/presentation/pages/internship_application_page.dart';
import 'package:intern_hup/feat/internships/presentation/pages/internship_applicants_page.dart';
import 'package:intern_hup/feat/internships/presentation/pages/applicant_details_page.dart';

class AppRouter {
  // ─── Route name constants ─────────────────────────────────────────────────
  static const String slashRoute = '/';
  static const String onBordingRoute = '/onBordingPage';
  static const String loginRoute = '/loginPage';
  static const String regesterRoute = '/regesterPage';
  static const String chooseAccountTypeRoute = '/chooseAccountType';
  static const String chooseTrackRoute = "/choose_track";
  static const String homePageStudentRoute = "/home_page_student";
  static const String profilePageStudentRoute = "/profile_page_student";
  static const String rootRouteStudent = "/rootStudent";
  static const String companyRegisterRoute = "/company_register";
  static const String dashBourdRoute = "/dash_bourd";
  static const String applecationRoute = "/applecation";
  static const String profileCompanyRoute = "/profile_company";
  static const String rootRouteCompany = "/rootCompany";
  static const String jopDetilsRoute = "/jopDetils";
  static const String internshipCompanyRoute = "/internship_company";
  static const String internshipApplicationRoute = "/internship-application";
  static const String internshipApplicantsRoute = "/internship-applicants";
  static const String applicantDetailsRoute = "/applicant-details";
  static const String homeRouteCompany = "/homeRouteCompany";
  static const String home_page_student = '/home_page_student';
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
        builder: (context, state) => const ChooseAccountTypePage(),
      ),

      GoRoute(
        path: home_page_student,
        builder: (context, state) => const HomePageStudent(),
      ), 

      GoRoute(
        path: homeRouteCompany,
        builder: (context, state) => const HomePageCompany(),
      ),

      GoRoute(
        path: profilePageStudentRoute,
        builder: (context, state) => const ProfilePageStudent(),
      ),

      GoRoute(
        path: chooseTrackRoute,
        builder: (context, state) => const ChooseTrackPage(),
      ),

      GoRoute(
        path: applecationRoute,
        builder: (context, state) => const ApplecationPage(),
      ),

      GoRoute(
        path: profileCompanyRoute,
        builder: (context, state) => const ProfileCompanyPage(),
      ),

      GoRoute(
        path: jopDetilsRoute,
        builder: (context, state) => const JopDetilsPage(),
      ),

      GoRoute(
        path: internshipCompanyRoute,
        builder: (context, state) => const HomePageCompany(),
      ),

      GoRoute(
        path: internshipApplicationRoute,
        builder: (context, state) {
          final internship = state.extra;
          if (internship is! InternshipEntity) {
            return const Scaffold(
              body: Center(child: Text('Internship details are unavailable.')),
            );
          }
          return InternshipApplicationPage(internship: internship);
        },
      ),

      GoRoute(
        path: internshipApplicantsRoute,
        builder: (context, state) {
          final internship = state.extra;
          if (internship is! InternshipEntity) {
            return const Scaffold(
              body: Center(child: Text('Internship details are unavailable.')),
            );
          }
          return InternshipApplicantsPage(internship: internship);
        },
      ),

      GoRoute(
        path: applicantDetailsRoute,
        builder: (context, state) {
          final applicant = state.extra;
          if (applicant is! InternshipApplicationEntity) {
            return const Scaffold(
              body: Center(child: Text('Applicant details are unavailable.')),
            );
          }
          return ApplicantDetailsPage(applicant: applicant);
        },
      ),
    ],
  );
}
