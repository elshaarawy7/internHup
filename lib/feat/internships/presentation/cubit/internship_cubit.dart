import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intern_hup/feat/internships/domain/entities/internship_entity.dart';
import 'package:intern_hup/feat/internships/domain/usecases/get_internships_use_case.dart';
import 'package:intern_hup/feat/internships/presentation/cubit/internship_state.dart';

class InternshipCubit extends Cubit<InternshipState> {
  InternshipCubit(this._getInternshipsUseCase)
    : super(const InternshipInitial());

  final GetInternshipsUseCase _getInternshipsUseCase;
  List<InternshipEntity> _allInternships = const [];
  String _searchQuery = '';

  String get searchQuery => _searchQuery;

  Future<void> getInternships() async {
    emit(const InternshipLoading());
    final result = await _getInternshipsUseCase();
    result.fold(
      (failure) => emit(InternshipError(failure.message)),
      (internships) {
        _allInternships = internships;
        _emitFilteredInternships();
      },
    );
  }

  /// Filters the internships already loaded from Supabase without another call.
  void searchInternships(String query) {
    _searchQuery = query.trim().toLowerCase();
    _emitFilteredInternships();
  }

  void _emitFilteredInternships() {
    if (_searchQuery.isEmpty) {
      emit(InternshipSuccess(_allInternships));
      return;
    }

    final internships = _allInternships.where((internship) {
      final searchableText = [
        internship.title,
        internship.companyName,
        internship.location,
        internship.description,
        internship.requirements ?? '',
      ].join(' ').toLowerCase();
      return searchableText.contains(_searchQuery);
    }).toList();

    emit(InternshipSuccess(internships));
  }
}
