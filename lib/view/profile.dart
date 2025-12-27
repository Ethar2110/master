import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:log/view/login.dart';
import '../cubit/dart/auth_cubit.dart';
import '../cubit/dart/theme_cubit.dart';
import '../cubit/dart/theme_state.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String selectedLanguage = "en";
  final user = FirebaseAuth.instance.currentUser;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    selectedLanguage = context.locale.languageCode;
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? Colors.black : Colors.white,
      appBar: AppBar(
        title: Text(
          "profile".tr(),
        ),
        backgroundColor: isDark ? Colors.grey[900] : Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 30.h),
        child: Column(
          children: [
            // Profile picture
            CircleAvatar(
              radius: 60.r,
              backgroundColor: Colors.grey[300],
              child: Icon(
                Icons.person,
                size: 60.r,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 15.h),

            // Email
            Text(
              user?.email ?? "No Email",
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white : Colors.grey[800],
              ),
            ),
            SizedBox(height: 40.h),

            // Language Selection
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "language".tr(),
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: isDark ? Colors.white : Colors.grey[800],
                ),
              ),
            ),
            RadioListTile<String>(
              value: "en",
              groupValue: selectedLanguage,
              title: Text("English"),
              activeColor: Colors.orange,
              onChanged: (value) {
                setState(() {
                  selectedLanguage = value!;
                  context.setLocale(const Locale('en'));
                });
              },
            ),
            RadioListTile<String>(
              value: "ar",
              groupValue: selectedLanguage,
              title: Text("العربية"),
              activeColor: Colors.orange,
              onChanged: (value) {
                setState(() {
                  selectedLanguage = value!;
                  context.setLocale(const Locale('ar'));
                });
              },
            ),
            SizedBox(height: 30.h),

            // Theme toggle
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  isDark ? "dark_theme".tr() : "light_theme".tr(),
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : Colors.grey[800],
                  ),
                ),
                BlocBuilder<ThemeCubit, ThemeState>(
                  builder: (context, themeState) {
                    return Switch(
                      value: themeState.isDark,
                      onChanged: (value) {
                        context.read<ThemeCubit>().toggleTheme();
                      },
                      activeColor: Colors.orange,
                    );
                  },
                ),
              ],
            ),
            SizedBox(height: 30.h),


             Align(
               alignment: AlignmentGeometry.centerLeft,
               child: TextButton(
                  onPressed: () {
                    context.read<AuthCubit>().signOut();
                    Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen() ));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.w),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  child: Text(
                    "Sign out",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
             ),

          ],
        ),
      ),
    );
  }
}
