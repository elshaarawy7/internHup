import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intern_hup/core/constant/app_color.dart';
import 'package:intern_hup/core/helper/app_router.dart';
import 'package:intern_hup/feat/company/data/models/internship_model.dart';
import 'package:intern_hup/feat/company/presentation/widgets/insternship_page_body.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HomePageCompany extends StatefulWidget {
  const HomePageCompany({super.key});

  static const String routeName = '/homeRouteCompany';

  @override
  State<HomePageCompany> createState() => _HomePageCompanyState();
}

class _HomePageCompanyState extends State<HomePageCompany> {
  List<InternshipModel> companyInternships = [];
  bool isLoading = true;
  String? loadError;

  @override
  void initState() {
    super.initState();
    fetchCompanyInternships();
  }

  Future<void> fetchCompanyInternships() async {
    final user = Supabase.instance.client.auth.currentUser;
    if (user == null) {
      if (mounted) {
        setState(() {
          isLoading = false;
          loadError = 'Please sign in to view your internships.';
        });
      }
      return;
    }

    if (mounted) {
      setState(() {
        isLoading = true;
        loadError = null;
      });
    }

    try {
      final response = await Supabase.instance.client
          .from('internships')
          .select()
          .eq('company_id', user.id)
          .order('created_at', ascending: false);

      final List<dynamic> data = response;
      final applicantCounts = await _getApplicantCounts(data);
      if (!mounted) return;
      setState(() {
        companyInternships = data.map((e) {
          final internship = Map<String, dynamic>.from(e as Map);
          internship['applicant_count'] =
              applicantCounts[internship['id']?.toString()] ?? 0;
          return InternshipModel.fromJson(internship);
        }).toList();
        isLoading = false;
      });
    } catch (error) {
      if (!mounted) return;
      setState(() {
        isLoading = false;
        loadError = 'Could not load internships: $error';
      });
    }
  }

  /// Keeps the company cards available when the applications table has not
  /// been created in Supabase yet. In that case every count is shown as zero.
  Future<Map<String, int>> _getApplicantCounts(
    List<dynamic> internships,
  ) async {
    final internshipIds = internships
        .map((internship) => (internship as Map)['id']?.toString())
        .whereType<String>()
        .toList();
    if (internshipIds.isEmpty) return const {};

    try {
      final response = await Supabase.instance.client
          .from('internship_applications')
          .select('internship_id')
          .inFilter('internship_id', internshipIds);
      final counts = <String, int>{};
      for (final application in response as List<dynamic>) {
        final internshipId = (application as Map)['internship_id']?.toString();
        if (internshipId != null) {
          counts.update(internshipId, (count) => count + 1, ifAbsent: () => 1);
        }
      }
      return counts;
    } catch (_) {
      return const {};
    }
  }

  // حذف تدريب معين من Supabase
  Future<void> deleteInternship(String id, int index) async {
    try {
      await Supabase.instance.client.from('internships').delete().eq('id', id);

      if (!mounted) return;
      setState(() {
        companyInternships.removeAt(index);
      });
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('خطأ في الحذف: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      floatingActionButtonLocation: FloatingActionButtonLocation.endContained,
      floatingActionButton: ElevatedButton(
        style: ElevatedButton.styleFrom(
          fixedSize: const Size(60, 60),
          backgroundColor: AppColors.primColor,
          shape: const CircleBorder(),
          padding: EdgeInsets.zero,
        ),
        onPressed: () async {
          final result = await context.push<InternshipModel>(
            AppRouter.jopDetilsRoute,
          );

          if (result != null) {
            setState(() {
              companyInternships.insert(0, result);
            });
          } else {
            await fetchCompanyInternships();
          }
        },
        child: const Icon(Icons.add, size: 30, color: Colors.white),
      ),
      body: InsternshipPageBody(
        internships: companyInternships,
        isLoading: isLoading,
        errorMessage: loadError,
        onRetry: fetchCompanyInternships,
        onDelete: (internship, index) async {
          final id = internship.id;
          if (id == null) return;
          await deleteInternship(id, index);
        },
      ),
    );
  }
}
