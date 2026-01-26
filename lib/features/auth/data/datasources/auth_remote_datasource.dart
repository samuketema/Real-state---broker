import 'package:realstate/core/error/exception.dart';
import 'package:realstate/features/auth/data/models/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class AuthRemoteDatasource {
  Future<UserModel> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  });
  Future<UserModel> logInWithEmailPassword({
    required String email,
    required String password,
  });
}

class AuthRemoteDatasourceImpl implements AuthRemoteDatasource {
  final SupabaseClient supabase;

  AuthRemoteDatasourceImpl({required this.supabase});
@override
Future<UserModel> logInWithEmailPassword({
  required String email,
  required String password,
}) async {
  try {
    final response = await supabase.auth.signInWithPassword(
      email: email,
      password: password,
    );

    final authUser = response.user;
    if (authUser == null) {
      throw ServerException("User is null");
    }

    final profile = await supabase
        .from('profiles')
        .select()
        .eq('user_id', authUser.id)
        .single();

    return UserModel.fromJson(profile);
  } on AuthException catch (e) {
    throw ServerException(e.message);
  } catch (e) {
    throw ServerException(e.toString());
  }
}


  @override
Future<UserModel> signUpWithEmailPassword({
  required String name,
  required String email,
  required String password,
}) async {
  try {
    final response = await supabase.auth.signUp(
      email: email,
      password: password,
      data: {"full_name": name},
    );

    final authUser = response.user;
    if (authUser == null) {
      throw ServerException("User is null");
    }

    // 🔥 THIS IS THE IMPORTANT PART
    final profile = await supabase
        .from('profiles')
        .select()
        .eq('user_id', authUser.id)
        .single();

    return UserModel.fromJson(profile);
  } on AuthException catch (e) {
    throw ServerException(e.message);
  } catch (e) {
    throw ServerException(e.toString());
  }
}

}
