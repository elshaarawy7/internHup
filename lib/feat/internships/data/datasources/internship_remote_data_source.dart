import 'package:intern_hup/core/error/exption.dart';
import 'package:intern_hup/feat/internships/data/models/internship_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class InternshipRemoteDataSource {
  Future<List<InternshipModel>> getInternships();
}

class InternshipRemoteDataSourceImpl implements InternshipRemoteDataSource {
  InternshipRemoteDataSourceImpl(this._supabase);

  final SupabaseClient _supabase;

  @override
  Future<List<InternshipModel>> getInternships() async {
    try {
      final now = DateTime.now().toUtc().toIso8601String();
      final response = await _supabase
          .from('internships')
          .select()
          .or('deadline.is.null,deadline.gte.$now')
          .order('created_at', ascending: false);

      return (response as List<dynamic>)
          .map(
            (json) => InternshipModel.fromJson(
              Map<String, dynamic>.from(json as Map),
            ),
          )
          .toList();
    } on PostgrestException catch (error) {
      throw CustomException(error.message);
    } catch (_) {
      throw CustomException('Unable to load internships. Please try again.');
    }
  }
}
