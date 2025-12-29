import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:log/view/verify.dart';
import 'package:log/view/wrapper.dart';

import '../cubit/dart/auth_cubit.dart';
import '../widgets/customBotton.dart';
import '../widgets/textField.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  // final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange.shade50,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.orange),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Create Account",
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.orange,
              ),
            ),
            const SizedBox(height: 40),

            // CustomTextField(
            //   hint: "Full Name",
            //   icon: Icons.person,
            //   controller: nameController,
            // ),
            // const SizedBox(height: 20),
            CustomTextField(
              hint: "Email",
              icon: Icons.email,
              controller: emailController,
            ),
            const SizedBox(height: 20),

            CustomTextField(
              hint: "Password",
              icon: Icons.lock,
              isPassword: true,
              controller: passwordController,
            ),
            const SizedBox(height: 30),

            CustomButton(
              text: "Sign Up",
                onPressed: () async {
                  final email = emailController.text.trim();
                  final password = passwordController.text.trim();

                  final error = await context.read<AuthCubit>().signUp(
                    email: email,
                    password: password,
                  );

                  if (error == null) {
                    // ✅ signup succeeded
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (_) => Wrapper()),
                          (route) => false,
                    );
                  } else {
                    // ❌ signup failed
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(error),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                }
            ),
          ],
        ),
      ),
    );
  }
}
