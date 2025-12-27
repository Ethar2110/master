import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:log/themes/dark_colors.dart';
import 'package:log/themes/light_colors.dart';
import 'package:log/view/wrapper.dart';
import 'cubit/dart/auth_cubit.dart';
import 'cubit/dart/best_price_cubit.dart';
import 'cubit/dart/cart_cubit.dart';
import 'cubit/dart/category_cubit.dart';
import 'cubit/dart/theme_cubit.dart';
import 'cubit/dart/theme_state.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await EasyLocalization.ensureInitialized();
  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ar')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      child: MultiBlocProvider(
        providers: [
          BlocProvider<CartCubit>(create: (context) => CartCubit()),
          BlocProvider(create: (context) => BestPriceCubit()),
          BlocProvider(create: (_) => ThemeCubit()),
          BlocProvider(create: (_) => CategoryCubit(),),
          BlocProvider(create: (_) => AuthCubit(),)


        ],
        child: const MyApp(),
      ),
    ),
  );
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
        return BlocBuilder<ThemeCubit, ThemeState>(
          builder: (context, themeState) {
            return MaterialApp(

              debugShowCheckedModeBanner: false,


              locale: context.locale,
              supportedLocales: context.supportedLocales,
              localizationsDelegates: context.localizationDelegates,


              theme: ThemeData(
                brightness: Brightness.light,
                primaryColor: LightColors.primary,
                scaffoldBackgroundColor: LightColors.background,
                cardColor: LightColors.card,
                dividerColor: LightColors.divider,
                textTheme: TextTheme(
                  bodyLarge: TextStyle(color: LightColors.textPrimary),
                  bodyMedium: TextStyle(color: LightColors.textSecondary),
                  titleLarge: TextStyle(color: LightColors.textPrimary), // for titles
                ),
                iconTheme: IconThemeData(color: LightColors.iconPrimary),
                appBarTheme: AppBarTheme(
                  backgroundColor: Colors.white,
                  elevation: 0,
                  iconTheme: IconThemeData(color: Colors.black),
                  titleTextStyle: TextStyle(color: Colors.black, fontSize: 20),
                ),

                bottomNavigationBarTheme: BottomNavigationBarThemeData(
                  backgroundColor: LightColors.primary,
                  type: BottomNavigationBarType.fixed,
                  elevation: 0,
                  selectedItemColor: LightColors.accent, // orange
                  unselectedItemColor: LightColors.iconSecondary, // grey
                  showUnselectedLabels: true,
                ),
              ),
              darkTheme: ThemeData(
                brightness: Brightness.dark,
                primaryColor: DarkColors.primary,
                scaffoldBackgroundColor: DarkColors.background,
                cardColor: DarkColors.card,
                dividerColor: DarkColors.divider,
                textTheme: TextTheme(
                  bodyLarge: TextStyle(color: DarkColors.textPrimary),
                  bodyMedium: TextStyle(color: DarkColors.textSecondary),
                  titleLarge: TextStyle(color: DarkColors.textPrimary), // for titles
                ),
                iconTheme: IconThemeData(color: DarkColors.iconPrimary),
                appBarTheme: AppBarTheme(
                  backgroundColor: DarkColors.background,
                  elevation: 0,
                  iconTheme: IconThemeData(color: DarkColors.iconPrimary),
                  titleTextStyle: TextStyle(color: DarkColors.textPrimary, fontSize: 20),
                ),

                bottomNavigationBarTheme: BottomNavigationBarThemeData(
                  backgroundColor: DarkColors.primary,
                  elevation: 0,
                  selectedItemColor: DarkColors.accent, // orange
                  unselectedItemColor: DarkColors.iconSecondary, // grey
                  showUnselectedLabels: true,
                ),
              ),
              themeMode: themeState.isDark ? ThemeMode.dark : ThemeMode.light,

              home: Wrapper(),
            );
          },
        );
      },
    );
  }
}
