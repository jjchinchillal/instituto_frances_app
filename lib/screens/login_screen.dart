import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../utils/app_colors.dart';
import '../widgets/custom_alert.dart';
import 'home_screen.dart';
import '../services/user_service.dart';
import '../data/user_data_store.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  bool _obscurePassword = true;

  Future<void> _signIn() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      _showAlert(
        title: 'Campos vacíos',
        message: 'Por favor ingresa tu correo y contraseña.',
        type: AlertType.warning,
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final response = await Supabase.instance.client.auth.signInWithPassword(
        email: email,
        password: password,
      );

      if (response.user != null) {
        // Traer datos de la tabla users
        final userData = await UserService.getUserDataByEmail();

        if (userData != null) {
          UserDataStore().setUserData(userData);
        }

        _showAlert(
          title: 'Bienvenido',
          message: 'Has iniciado sesión correctamente.',
          type: AlertType.success,
        );

        if (mounted) {
          Future.delayed(const Duration(seconds: 1), () {
            if (mounted) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const HomeScreen()),
              );
            }
          });
        }
      } else {
        _showAlert(
          title: 'Error',
          message: 'No se pudo iniciar sesión. Intenta nuevamente.',
          type: AlertType.error,
        );
      }
    } on AuthException {
      _showAlert(
        title: 'Error',
        message: 'Correo o contraseña incorrectos',
        type: AlertType.error,
      );
    } catch (e) {
      _showAlert(
        title: 'Error inesperado',
        message: '$e',
        type: AlertType.error,
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _showAlert({
    required String title,
    required String message,
    required AlertType type,
  }) {
    CustomAlert.show(context, title: title, message: message, type: type);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  'assets/images/Imagotipo-Separado-NBG.png',
                  height: 120,
                ),
                const SizedBox(height: 20),
                Text(
                  'Ingresa tus datos',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 30),
                TextField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: 'Correo electrónico',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: _passwordController,
                  obscureText: _obscurePassword,
                  decoration: InputDecoration(
                    labelText: 'Contraseña',
                    border: const OutlineInputBorder(),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                _isLoading
                    ? const CircularProgressIndicator()
                    : ElevatedButton(
                      onPressed: _signIn,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.secondary,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 40,
                          vertical: 15,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Iniciar Sesión',
                        style: TextStyle(fontSize: 16),
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
