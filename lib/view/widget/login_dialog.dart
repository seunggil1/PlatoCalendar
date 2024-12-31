import 'package:flutter/material.dart';
import 'package:plato_calendar/model/model.dart';

class LoginDialog extends StatefulWidget {
  const LoginDialog({super.key});

  @override
  State<LoginDialog> createState() => _LoginDialogState();
}

class _LoginDialogState extends State<LoginDialog> {
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Login'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _idController,
            decoration: const InputDecoration(
              labelText: 'ID',
            ),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _pwController,
            decoration: const InputDecoration(
              labelText: 'Password',
            ),
            obscureText: true,
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            final username = _idController.text;
            final password = _pwController.text;

            final credentialInfo = PlatoCredential()
              ..username = username
              ..password = password;

            // 다이얼로그 닫기
            Navigator.of(context).pop(credentialInfo);
          },
          child: const Text('Login'),
        ),
      ],
    );
  }
}
