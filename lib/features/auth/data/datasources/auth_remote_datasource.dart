import 'package:realstate/core/error/exception.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class AuthRemoteDatasource {
  Future<String> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password
  });
  Future<String> logInWithEmailPassword({
    required String email,
    required String password
  });
}

class AuthRemoteDatasourceImpl implements AuthRemoteDatasource {
  final SupabaseClient supabase;

  AuthRemoteDatasourceImpl({required this.supabase});
  Future<String> logInWithEmailPassword({required String email, required String password}) {
    // TODO: implement logInWithEmailPassword
    throw UnimplementedError();
  }

  @override
  Future<String> signUpWithEmailPassword({required String name, required String email, required String password}) async{
    try {
      final response = await supabase.auth.signUp(password: password,email: email,data: {"name":name});
      if (response.user == null) {   
        throw ServerException("User is null");   
      }
      return response.user!.id;
    }on AuthException catch (e) {
    throw ServerException(e.message);
  } catch (e) {   
      throw ServerException(e.toString());
    }
  }

}