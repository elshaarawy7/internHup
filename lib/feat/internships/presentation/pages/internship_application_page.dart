import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intern_hup/core/constant/app_color.dart';
import 'package:intern_hup/feat/internships/domain/entities/internship_entity.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class InternshipApplicationPage extends StatefulWidget {
  const InternshipApplicationPage({super.key, required this.internship});

  final InternshipEntity internship;

  @override
  State<InternshipApplicationPage> createState() =>
      _InternshipApplicationPageState();
}

class _InternshipApplicationPageState extends State<InternshipApplicationPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _coverLetterController = TextEditingController();
  Uint8List? _cvBytes;
  String? _cvFileName;
  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();
    final user = Supabase.instance.client.auth.currentUser;
    final metadata = user?.userMetadata ?? const <String, dynamic>{};
    _nameController.text =
        metadata['full_name']?.toString() ?? metadata['name']?.toString() ?? '';
    _emailController.text = user?.email ?? '';
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _coverLetterController.dispose();
    super.dispose();
  }

  Future<void> _submitApplication() async {
    if (!_formKey.currentState!.validate()) return;
    if (_cvBytes == null || _cvFileName == null) {
      _showMessage('Please upload your CV before submitting.', isError: true);
      return;
    }
    final internshipId = widget.internship.id;
    final user = Supabase.instance.client.auth.currentUser;
    if (internshipId == null || user == null) {
      _showMessage('Please sign in before applying.', isError: true);
      return;
    }
    if (widget.internship.deadline?.isBefore(DateTime.now()) ?? false) {
      _showMessage('The application deadline has passed.', isError: true);
      return;
    }

    setState(() => _isSubmitting = true);
    String? cvPath;
    var wasSubmitted = false;
    try {
      cvPath = await _uploadCv(user.id, internshipId);
      await Supabase.instance.client.from('internship_applications').insert({
        'internship_id': internshipId,
        'student_id': user.id,
        'student_name': _nameController.text.trim(),
        'student_email': _emailController.text.trim(),
        'cover_letter': _coverLetterController.text.trim(),
        'cv_path': cvPath,
        'cv_file_name': _cvFileName,
      });
      wasSubmitted = true;
      if (!mounted) return;
      context.pop(true);
    } on PostgrestException catch (error) {
      if (!mounted) return;
      final isDuplicateApplication = error.code == '23505';
      _showMessage(
        isDuplicateApplication
            ? 'You have already applied for this internship.'
            : _applicationDatabaseError(error),
        isError: true,
      );
    } on StorageException catch (error) {
      if (mounted) {
        _showMessage(_cvStorageError(error), isError: true);
      }
    } catch (error) {
      debugPrint('Internship application error: $error');
      if (mounted) {
        _showMessage('Could not submit your application. Please try again.',
            isError: true);
      }
    } finally {
      if (cvPath != null && !wasSubmitted) {
        try {
          await Supabase.instance.client.storage.from('cvs').remove([cvPath]);
        } catch (_) {
          // The next successful CV upload is unaffected if cleanup fails.
        }
      }
      if (mounted) setState(() => _isSubmitting = false);
    }
  }

  Future<void> _pickCv() async {
    try {
      final file = await FilePicker.pickFile(
        type: FileType.custom,
        allowedExtensions: const ['pdf', 'doc', 'docx'],
      );
      if (file == null) return;

      final bytes = await file.readAsBytes();
      const maxFileSizeInBytes = 5 * 1024 * 1024;
      if (bytes.lengthInBytes > maxFileSizeInBytes) {
        if (mounted) {
          _showMessage('Your CV must be 5 MB or smaller.', isError: true);
        }
        return;
      }

      if (mounted) {
        setState(() {
          _cvBytes = bytes;
          _cvFileName = file.name;
        });
      }
    } catch (_) {
      if (mounted) {
        _showMessage('Could not select the CV file. Please try again.',
            isError: true);
      }
    }
  }

  Future<String> _uploadCv(String studentId, String internshipId) async {
    final safeFileName = _cvFileName!.replaceAll(
      RegExp(r'[^a-zA-Z0-9._-]'),
      '_',
    );
    final path = '$studentId/${DateTime.now().millisecondsSinceEpoch}_'
        '${internshipId}_$safeFileName';
    await Supabase.instance.client.storage
        .from('cvs')
        .uploadBinary(path, _cvBytes!);
    return path;
  }

  String _applicationDatabaseError(PostgrestException error) {
    if (error.code == 'PGRST205' ||
        error.code == 'PGRST200' ||
        error.code == '42P01') {
      return 'Applications are not set up in Supabase yet. Run the '
          'internship applications migration in Supabase SQL Editor.';
    }
    if (error.code == '42501') {
      return 'Supabase denied this application. Check the applications '
          'table RLS policies in the migration.';
    }
    return 'Could not save the application: ${error.message}';
  }

  String _cvStorageError(StorageException error) {
    final details = error.message.toLowerCase();
    if (details.contains('bucket') ||
        details.contains('not found') ||
        details.contains('row-level security') ||
        details.contains('permission')) {
      return 'CV upload is not configured in Supabase. Run the internship '
          'applications migration to create the cvs bucket and its policies.';
    }
    return 'Could not upload your CV: ${error.message}';
  }

  void _showMessage(String message, {required bool isError}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red : Colors.green,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: const Text('Apply for internship'),
        backgroundColor: AppColors.backgroundColor,
        surfaceTintColor: Colors.transparent,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.internship.title,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  widget.internship.companyName,
                  style: const TextStyle(color: Color(0xFF64748B)),
                ),
                const SizedBox(height: 28),
                _ApplicationTextField(
                  controller: _nameController,
                  label: 'Full name',
                  hintText: 'Enter your full name',
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: 16),
                _ApplicationTextField(
                  controller: _emailController,
                  label: 'Email address',
                  hintText: 'Enter your email address',
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    final email = value?.trim() ?? '';
                    if (!RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(email)) {
                      return 'Enter a valid email address.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                _ApplicationTextField(
                  controller: _coverLetterController,
                  label: 'Why are you a good fit?',
                  hintText: 'Write a short message to the company',
                  maxLines: 6,
                  textInputAction: TextInputAction.done,
                ),
                const SizedBox(height: 16),
                const Text(
                  'CV / Resume',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 8),
                OutlinedButton.icon(
                  onPressed: _isSubmitting ? null : _pickCv,
                  icon: const Icon(Icons.upload_file_outlined),
                  label: Text(
                    _cvFileName == null ? 'Upload CV (PDF, DOC, DOCX)' : _cvFileName!,
                    overflow: TextOverflow.ellipsis,
                  ),
                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size.fromHeight(52),
                    alignment: Alignment.centerLeft,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                const Text(
                  'Maximum file size: 5 MB',
                  style: TextStyle(color: Color(0xFF64748B), fontSize: 12),
                ),
                const SizedBox(height: 28),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _isSubmitting ? null : _submitApplication,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primColor,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: _isSubmitting
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : const Text('Submit application'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ApplicationTextField extends StatelessWidget {
  const _ApplicationTextField({
    required this.controller,
    required this.label,
    required this.hintText,
    required this.textInputAction,
    this.keyboardType,
    this.maxLines = 1,
    this.validator,
  });

  final TextEditingController controller;
  final String label;
  final String hintText;
  final TextInputAction textInputAction;
  final TextInputType? keyboardType;
  final int maxLines;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          textInputAction: textInputAction,
          maxLines: maxLines,
          validator: validator ?? (value) {
            if (value == null || value.trim().isEmpty) {
              return 'This field is required.';
            }
            return null;
          },
          decoration: InputDecoration(
            hintText: hintText,
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
            ),
          ),
        ),
      ],
    );
  }
}
