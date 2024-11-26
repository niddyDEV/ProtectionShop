import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String name = 'Имя Фамилия';
  String phone = '+7 (123) 456-78-90';
  String email = 'example@example.com';

  void _editProfile() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Редактировать профиль'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: const InputDecoration(labelText: 'Имя'),
                onChanged: (value) {
                  setState(() {
                    name = value;
                  });
                },
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'Телефон'),
                onChanged: (value) {
                  setState(() {
                    phone = value;
                  });
                },
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'Email'),
                onChanged: (value) {
                  setState(() {
                    email = value;
                  });
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Сохранить'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Профиль'),
        centerTitle: true, // Выравнивание заголовка по центру
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: _editProfile,
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // Выравнивание по центру по вертикали
            children: [
              const CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage('assets/images/profile.jpg'),
              ),
              const SizedBox(height: 16),
              Text(
                name,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center, // Выравнивание текста по центру
              ),
              const SizedBox(height: 8),
              Text(
                phone,
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.grey, // Добавление цвета для текста
                ),
                textAlign: TextAlign.center, // Выравнивание текста по центру
              ),
              const SizedBox(height: 8),
              Text(
                email,
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.grey, // Добавление цвета для текста
                ),
                textAlign: TextAlign.center, // Выравнивание текста по центру
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}