import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:log/view/home_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubit/dart/best_price_cubit.dart';
import 'cubit/dart/cart_cubit.dart';

void main() {
  runApp( MultiBlocProvider(
      providers: [
        BlocProvider<CartCubit>(
          create: (context) => CartCubit(),
        ),
        BlocProvider(
        create: (context) => BestPriceCubit(),
        )
  ],
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: HomePage(),
        );
      },
    );


  }
}


