import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:intern_hup/core/constant/app_color.dart';
import 'package:intern_hup/feat/auth/presentation/widgets/auth_primary_button.dart';
import 'package:intern_hup/feat/company/data/models/internship_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class InternshipDetilsPageBody extends StatefulWidget {
  const InternshipDetilsPageBody({super.key});

  @override
  State<InternshipDetilsPageBody> createState() =>
      _InternshipDetilsPageBodyState();
}

class _InternshipDetilsPageBodyState extends State<InternshipDetilsPageBody> {
  final TextEditingController companyNameController = TextEditingController();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController requirementsController = TextEditingController();
  final TextEditingController durationController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  bool isPade = false;
  DateTime? selectedDeadline;
  final TextEditingController dateController = TextEditingController();

  Future<void> _selectDeadline(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().add(
        const Duration(days: 30),
      ), // التاريخ الافتراضي: بعد شهر
      firstDate: DateTime.now(), // لا يمكن اختيار تاريخ قديم
      lastDate: DateTime.now().add(const Duration(days: 365)), // أقصى حد سنة
    );

    if (picked == null) return;

    final selectedTime = await showTimePicker(
      context: context,
      initialTime: selectedDeadline != null
          ? TimeOfDay.fromDateTime(selectedDeadline!)
          : const TimeOfDay(hour: 17, minute: 0),
      helpText: 'Select application closing time',
    );
    if (selectedTime == null || !mounted) return;

    final deadline = DateTime(
      picked.year,
      picked.month,
      picked.day,
      selectedTime.hour,
      selectedTime.minute,
    );
    setState(() {
      selectedDeadline = deadline;
      dateController.text = _formatDeadline(deadline);
    });
  }

  String _formatDeadline(DateTime deadline) {
    final hour = deadline.hour % 12 == 0 ? 12 : deadline.hour % 12;
    final period = deadline.hour >= 12 ? 'PM' : 'AM';
    return '${deadline.year}-${deadline.month.toString().padLeft(2, '0')}-${deadline.day.toString().padLeft(2, '0')} '
        '${hour.toString().padLeft(2, '0')}:${deadline.minute.toString().padLeft(2, '0')} $period';
  }

  @override
  void dispose() {
    companyNameController.dispose();
    titleController.dispose();
    locationController.dispose();
    descriptionController.dispose();
    requirementsController.dispose();
    durationController.dispose();
    dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Gap(70),
              Text(
                "Internship Details",
                style: TextStyle(
                  color: AppColors.primColor,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              Gap(20),

              CustomTextField(
                controller: companyNameController,
                label: "Company name",
                hintText: "Enter your company name",
                isRequired: true,
              ),

              Gap(20),

              CustomTextField(
                controller: titleController,
                label: "Internship title",
                hintText: "e.g. Backend Intern",
                isRequired: true,
              ),

              Gap(20),

              CustomTextField(
                controller: locationController,
                label: "location",
                hintText: "location",
                isRequired: true,
              ),

              Gap(20),

              CustomTextField(
                controller: descriptionController,
                label: "description",
                hintText: "description",
                isRequired: true,
                maxLines: 6,
              ),

              Gap(20),

              CustomTextField(
                controller: dateController,
                label: "Application deadline",
                hintText: "Choose the closing date and time",
                isRequired: true,
                suffixIcon: Icon(
                  Icons.calendar_today,
                  color: AppColors.primColor,
                ),
                readOnly: true,
                onTap: () => _selectDeadline(context),
              ),

              Gap(20),

              CustomTextField(
                controller: requirementsController,
                label: "Requirements",
                hintText: "List the skills and qualifications needed",
                isRequired: true,
                maxLines: 6,
              ),

              Gap(20),

              CustomTextField(
                controller: durationController,
                label: "Internship duration",
                hintText: "e.g. 3 months",
                isRequired: true,
              ),

              Gap(20),

              PaidInternshipOption(
                initialValue: isPade,
                onChanged: (value) {
                  isPade = value ?? false;
                },
              ),

              Gap(20),

              CustemBatton(
  text: "Publish",
  onPressed: () async {
    // 1. التأكد من صحة الحقول
    if (formKey.currentState!.validate()) {
      final user = Supabase.instance.client.auth.currentUser;

      // التأكد من تسجيل الدخول
      if (user == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('الرجاء تسجيل الدخول أولاً')),
        );
        return;
      }

      try {
        // 2. رفع البيانات لـ Supabase
        final createdInternship = await Supabase.instance.client
            .from('internships')
            .insert({
          'company_id': user.id,
          'company_name': companyNameController.text.trim(),
          'title': titleController.text,
          'location': locationController.text,
          'description': descriptionController.text,
          'is_paid': isPade,
          'duration': durationController.text.trim(),
          'requirements': requirementsController.text.trim(),
          'deadline': selectedDeadline?.toIso8601String(),
        })
            .select()
            .single();

        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('تم نشر التدريب بنجاح!')),
          );
          context.pop(InternshipModel.fromJson(createdInternship));
        }
      } catch (error) {
        // 3. طابعة الخطأ لو فيه مشكلة في Supabase
        print("Supabase Insert Error: $error");
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('حدث خطأ: $error')),
          );
        }
      }
    }
  },
),

              Gap(50),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  final String label;
  final String hintText;
  final bool isRequired;
  final TextEditingController? controller;
  final Widget? suffixIcon;
  final bool readOnly;
  final VoidCallback? onTap;
  final int? maxLines;

  const CustomTextField({
    super.key,
    required this.label,
    required this.hintText,
    this.isRequired = false,
    this.controller,
    this.suffixIcon,
    this.readOnly = false,
    this.onTap,
    this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title Text with optional red asterisk
        RichText(
          text: TextSpan(
            text: label,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2D3748),
            ),
          ),
        ),
        const SizedBox(height: 10),

        // Text Form Field Component
        TextFormField(
          controller: controller,
          readOnly: readOnly,
          onTap: onTap,
          maxLines: maxLines,
          validator: (value) {
            if (isRequired && (value == null || value.isEmpty)) {
              return "This field is required";
            }
            return null;
          },
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: const TextStyle(color: Color(0xFF8C98A8), fontSize: 16),
            suffixIcon: suffixIcon,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 18,
            ),
            filled: true,
            fillColor: Colors.white,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(
                color: Color(0xFFD1D5DB),
                width: 1.5,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(color: Colors.blue, width: 2),
            ),

            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(color: Colors.blue, width: 2),
            ),
          ),

          errorBuilder: (context, errorText) {
            return Text(errorText);
          },
        ),
      ],
    );
  }
}

class PaidInternshipOption extends StatefulWidget {
  final ValueChanged<bool?>? onChanged;
  final bool initialValue;

  const PaidInternshipOption({
    super.key,
    this.onChanged,
    this.initialValue = false,
  });

  @override
  State<PaidInternshipOption> createState() => _PaidInternshipOptionState();
}

class _PaidInternshipOptionState extends State<PaidInternshipOption> {
  late bool isChecked;

  @override
  void initState() {
    super.initState();
    isChecked = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          isChecked = !isChecked;
        });
        if (widget.onChanged != null) {
          widget.onChanged!(isChecked);
        }
      },
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // النص بالإنجليزي
            const Text(
              'Paid Internship',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Color(0xFF2D3748),
              ),
            ),

            // الـ Checkbox (مستقل وغير إجباري)
            Checkbox(
              value: isChecked,
              activeColor: Colors.blue, // لون الـ Checkbox لما يتقفل
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  4,
                ), // حواف دائرية بسيطة للـ Checkbox
              ),
              onChanged: (bool? value) {
                setState(() {
                  isChecked = value ?? false;
                });
                if (widget.onChanged != null) {
                  widget.onChanged!(isChecked);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
