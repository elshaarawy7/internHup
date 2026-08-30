import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intern_hup/core/constant/app_color.dart';
import 'package:intern_hup/core/helper/app_router.dart';
import 'package:intern_hup/feat/company/data/models/internship_model.dart';
import 'package:intern_hup/feat/company/presentation/widgets/insternship_page_body.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class InternShipPage extends StatefulWidget {
  const InternShipPage({super.key});

  static const String routeName = '/internShipPage'; 

  @override
  State<InternShipPage> createState() => _InternShipPageState();
}

class _InternShipPageState extends State<InternShipPage> {
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
      if (!mounted) return;
      setState(() {
        companyInternships = data
            .map((e) => InternshipModel.fromJson(e as Map<String, dynamic>))
            .toList();
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

  // حذف تدريب معين من Supabase
  Future<void> deleteInternship(String id, int index) async {
    try {
      await Supabase.instance.client
          .from('internships')
          .delete()
          .eq('id', id);

      if (!mounted) return;
      setState(() {
        companyInternships.removeAt(index);
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('خطأ في الحذف: $e')),
      );
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
