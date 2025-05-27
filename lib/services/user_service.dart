import 'package:supabase_flutter/supabase_flutter.dart';

class UserService {
  static final _client = Supabase.instance.client;

  /// Obtiene los datos del usuario logueado desde la tabla 'users' buscando por email
  static Future<Map<String, dynamic>?> getUserDataByEmail() async {
    final user = _client.auth.currentUser;
    if (user == null) return null;

    final email = user.email;
    if (email == null) return null;

    try {
      final data =
          await _client.from('users').select().eq('email', email).maybeSingle();

      return data;
    } catch (error) {
      throw Exception('Error al obtener datos del usuario: $error');
    }
  }
}
