import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:log/view/home_page.dart';
import 'package:log/view/login.dart';
import 'package:log/view/verify.dart';

import '../cubit/dart/auth_cubit.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({super.key});

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  Widget build(BuildContext context) {
    return  StreamBuilder(stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context,snapshot){
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
        if(snapshot.hasData){
            return HomePage();
        }else{
          return BlocProvider.value(
            value: context.read<AuthCubit>(),
            child: LoginScreen(),
          );
        }
          }

    );
  }
}
