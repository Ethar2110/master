import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:log/view/forgotPassword.dart';
import 'package:log/view/home_page.dart';
import 'package:log/view/signUp.dart';
import 'package:log/view/wrapper.dart';

import '../cubit/dart/auth_cubit.dart';
import '../cubit/dart/auth_state.dart';
import '../widgets/customBotton.dart';
import '../widgets/textField.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return  BlocListener<AuthCubit, AuthenticationState>(
        listener: (context, state) {
      if (state is EmailError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(state.message),
            backgroundColor: Colors.red,
          ),
        );
      }

    },
    child: Scaffold(
      backgroundColor: Colors.orange.shade50,
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Welcome Back",
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.orange,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              "Login to continue",
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 40),

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
            const SizedBox(height: 5),

            Row(
              children: [
                Spacer(),
                TextButton(
                  onPressed: () {
                   Navigator.push(context, MaterialPageRoute(builder: (context) => ForgotPasswordPage()));
                  },
                  child: Text(
                    "Forgot Password?",
                    style: TextStyle(color: Colors.grey[500], fontSize: 13),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 5),

            CustomButton(
              text: "Login",
              onPressed: () async {
                final email = emailController.text.trim();
                final password = passwordController.text.trim();

                final String? error = await context.read<AuthCubit>().signIn(
                  email: email,
                  password: password,
                );

                if (error != null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(error),
                      backgroundColor: Colors.red,
                    ),
                  );
                } else {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => const Wrapper()),
                        (route) => false,
                  );
                }
              },
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              onPressed: () async {
                final authCubit = context.read<AuthCubit>();

                // call Google sign-in
                await authCubit.signInWithGoogle();

                // handle result
                final state = authCubit.state;
                if (state is EmailError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.message),
                      backgroundColor: Colors.red,
                    ),
                  );
                } else if (FirebaseAuth.instance.currentUser != null) {
                  // Google login successful → navigate
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => const Wrapper()),
                        (route) => false,
                  );
                }
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.g_mobiledata, color: Colors.blue, size: 30),
                  SizedBox(width: 8),
                  Text(
                    "Sign in with Google",
                    style: TextStyle(color: Colors.black),
                  ),
                ],
              ),
            ),



            TextButton(
              onPressed: () {
               Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpScreen()));
              },
              child: const Text(
                "Don't have an account? Sign Up",
                style: TextStyle(color: Colors.orange),
              ),
            ),
          ],
        ),
      ),
    )
    );
  }
}
