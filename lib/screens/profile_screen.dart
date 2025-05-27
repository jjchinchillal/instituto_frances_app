import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import '../data/user_data_store.dart';
import '../widgets/back_floating_button.dart';

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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: const Text('Perfil', style: TextStyle(color: Colors.white)),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body:
          _isLoading
              ? const Center(child: CircularProgressIndicator())
              : _error != null
              ? Center(child: Text(_error!))
              : _buildProfileContent(),
      floatingActionButton: const BackFloatingButton(),
    );
  }

  Widget _buildProfileContent() {
    final name = _userData?['name'] ?? 'No disponible';
    final email = _userData?['email'] ?? 'No disponible';
    final photo = _userData?['photo'];
    final description = _userData?['description'] ?? 'Sin descripción';
    final role = _userData?['role'] ?? 'No especificado';

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 60,
            backgroundColor: AppColors.secondary.withAlpha(50),
            backgroundImage: photo != null ? NetworkImage(photo) : null,
            child:
                photo == null
                    ? const Icon(Icons.person, size: 60, color: Colors.white)
                    : null,
          ),
          const SizedBox(height: 20),
          Text(
            name,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            email,
            style: const TextStyle(fontSize: 16, color: Colors.black54),
          ),
          const SizedBox(height: 30),
          _buildInfoCard(title: 'Descripción', value: description),
          const SizedBox(height: 20),
          _buildInfoCard(title: 'Rol', value: role),
        ],
      ),
    );
  }

  Widget _buildInfoCard({required String title, required String value}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.secondary.withAlpha(60)),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: const Offset(2, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.black54,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(fontSize: 16, color: Colors.black87),
          ),
        ],
      ),
    );
  }
}
