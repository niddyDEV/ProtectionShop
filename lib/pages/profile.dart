import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:prk3_3_3/api/supabase.dart';
import 'package:prk3_3_3/pages/auth.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  // Переменная для хранения email пользователя
  String? _userEmail;

  @override
  void initState() {
    super.initState();
    // Получаем текущую сессию пользователя
    _loadUserEmail();
  }

  // Метод для загрузки email пользователя
  Future<void> _loadUserEmail() async {
    final supabase = SupabaseService().client; // Получаем клиент Supabase
    final session = supabase.auth.currentSession;

    if (session != null && session.user != null) {
      setState(() {
        _userEmail = session.user!.email; // Получаем email пользователя
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final supabase = SupabaseService().client; // Получаем клиент Supabase

    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'ПРОФИЛЬ',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              letterSpacing: 6,
              fontSize: 30,
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await supabase.auth.signOut(); // Используем supabase для выхода
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => const AuthPage()),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage('assets/images/scale_1200.png'),
              ),
              const SizedBox(height: 16),
              const Text(
                'John Doe DeJean',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                'Телефон: +7 (123) 456-78-90',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 8),
              Text(
                'Email: ${_userEmail ?? 'Загрузка...'}', // Отображаем email или сообщение "Загрузка..."
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}