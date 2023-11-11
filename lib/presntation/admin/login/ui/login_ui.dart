import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../data/providers/auth_notification.dart';

class AdminLoginPage extends StatefulWidget {
  const AdminLoginPage({Key? key}) : super(key: key);

  @override
  State<AdminLoginPage> createState() => _AdminLoginPageState();
}

class _AdminLoginPageState extends State<AdminLoginPage> {
  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              const Text(
                'Administration ',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      const Text(
                        'Accéder à la page de connexion accéder à l\'administration de Diarra',
                      ),
                      const SizedBox(height: 20),
                      TextField(
                        controller: emailController,
                        decoration: InputDecoration(labelText: 'Email'),
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        controller: passwordController,
                        decoration: InputDecoration(labelText: 'Password'),
                        obscureText: true,
                      ),
                      const SizedBox(height: 20),
                    Consumer(builder: ((context, ref, _) {
                bool isLoading = ref.watch(authNotifierProvider);
                return Column(
                  children: [
                    isLoading ? CircularProgressIndicator() : ElevatedButton(
                      onPressed: () {
                        ref.read(authNotifierProvider.notifier).login(
                          email: emailController.text,
                          password: passwordController.text,
                          context: context,
                        );
                      },
                      child: const Text('Connexion'),
                    ),
                    StreamBuilder<String>(
                      stream: ref.read(authNotifierProvider.notifier).errorStream,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Text(
                            snapshot.data!,
                            style: const TextStyle(color: Colors.red),
                          );
                        } else {
                          return const SizedBox(); // Ou un widget vide si pas d'erreur.
                        }
                      },
                    ),
                  ],
                );
              }))
            ],
          ),
        ),
      ),
            ]))));
  }
}