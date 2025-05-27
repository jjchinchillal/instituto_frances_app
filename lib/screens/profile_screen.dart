import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import '../data/user_data_store.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Map<String, dynamic>? _userData;
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadUserDataLocal();
  }

  void _loadUserDataLocal() {
    final data = UserDataStore().getUserData();
    if (data == null) {
      setState(() {
        _error = 'No hay datos del usuario. Por favor inicia sesión.';
        _isLoading = false;
      });
    } else {
      setState(() {
        _userData = data;
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Perfil'),
          backgroundColor: AppColors.primary,
        ),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    if (_error != null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Perfil'),
          backgroundColor: AppColors.primary,
        ),
        body: Center(child: Text(_error!)),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil'),
        backgroundColor: AppColors.primary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Nombre: ${_userData?['name'] ?? 'No disponible'}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 10),
            Text(
              'Correo: ${_userData?['email'] ?? 'No disponible'}',
              style: const TextStyle(fontSize: 16),
            ),
            // Puedes agregar más campos que tengas en la tabla 'users'
          ],
        ),
      ),
    );
  }
}
