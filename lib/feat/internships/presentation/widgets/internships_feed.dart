import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intern_hup/core/services/getit.dart';
import 'package:intern_hup/feat/internships/presentation/cubit/internship_cubit.dart';
import 'package:intern_hup/feat/internships/presentation/cubit/internship_state.dart';
import 'package:intern_hup/feat/internships/presentation/widgets/internship_card.dart';

class InternshipsFeed extends StatefulWidget {
  const InternshipsFeed({super.key});

  @override
  State<InternshipsFeed> createState() => _InternshipsFeedState();
}

class _InternshipsFeedState extends State<InternshipsFeed> {
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<InternshipCubit>()..getInternships(),
      child: Builder(
        builder: (context) => Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
              child: TextField(
                controller: _searchController,
                onChanged: context.read<InternshipCubit>().searchInternships,
                textInputAction: TextInputAction.search,
                decoration: InputDecoration(
                  hintText: 'Search by role, company, location, or skill',
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: _searchController.text.isEmpty
                      ? null
                      : IconButton(
                          tooltip: 'Clear search',
                          icon: const Icon(Icons.clear),
                          onPressed: () {
                            _searchController.clear();
                            context.read<InternshipCubit>().searchInternships(
                              '',
                            );
                            setState(() {});
                          },
                        ),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
                  ),
                ),
              ),
            ),
            Expanded(
              child: BlocBuilder<InternshipCubit, InternshipState>(
                builder: (context, state) {
                  if (state is InternshipLoading || state is InternshipInitial) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (state is InternshipError) {
                    return _LoadError(
                      message: state.message,
                      onRetry: context.read<InternshipCubit>().getInternships,
                    );
                  }
                  if (state is InternshipSuccess) {
                    if (state.internships.isEmpty) {
                      final hasSearchQuery = context
                          .read<InternshipCubit>()
                          .searchQuery
                          .isNotEmpty;
                      return Center(
                        child: Text(
                          hasSearchQuery
                              ? 'No internships match your search.'
                              : 'No open internships are available right now.',
                        ),
                      );
                    }
                    return RefreshIndicator(
                      onRefresh: context
                          .read<InternshipCubit>()
                          .getInternships,
                      child: ListView.builder(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        itemCount: state.internships.length,
                        itemBuilder: (context, index) {
                          final internship = state.internships[index];
                          return InternshipCard(
                            internship: internship,
                            isCompany: false,
                            onApply: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'Application started for ${internship.title}.',
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LoadError extends StatelessWidget {
  const _LoadError({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.error_outline, color: Colors.red, size: 36),
            const SizedBox(height: 12),
            Text(message, textAlign: TextAlign.center),
            const SizedBox(height: 12),
            ElevatedButton(onPressed: onRetry, child: const Text('Try again')),
          ],
        ),
      ),
    );
  }
}
