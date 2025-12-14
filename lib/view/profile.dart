import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../cubit/dart/theme_cubit.dart';
import '../cubit/dart/theme_state.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String selectedLanguage = "en";

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    selectedLanguage = context.locale.languageCode;
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final containerColor = isDark ? Colors.grey[800] : Colors.grey[300];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "profile".tr(),
          style: TextStyle(color: Theme.of(context).textTheme.bodyLarge?.color),
        ),
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      ),
      body: Center(
        child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 50.w),
            child:
         Container(
          padding: EdgeInsets.all(30.r),
          decoration: BoxDecoration(
            color: containerColor,
            borderRadius: BorderRadius.circular(15.r),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "language".tr(),
                style: TextStyle(color: Theme.of(context).textTheme.bodyLarge?.color),
              ),
              SizedBox(height: 10.h),
              Column(
                children: [
                  RadioListTile<String>(
                    value: "en",
                    fillColor: MaterialStateProperty.resolveWith<Color>((
                        state,
                        ) {
                      if (state.contains(MaterialState.selected)) {
                        return Colors.orange;
                      }
                      return Colors.grey;
                    }),
                    groupValue: selectedLanguage,
                    title: Text("English"),
                    onChanged: (value) {
                      setState(() {
                        selectedLanguage = value!;
                        context.setLocale(const Locale('en'));
                      });
                    },
                  ),
                  RadioListTile<String>(
                    value: "ar",
                    fillColor: MaterialStateProperty.resolveWith<Color>((
                        state,
                        ) {
                      if (state.contains(MaterialState.selected)) {
                        return Colors.orange;
                      }
                      return Colors.grey;
                    }),
                    groupValue: selectedLanguage,
                    title: Text("العربية"),
                    onChanged: (value) {
                      setState(() {
                        selectedLanguage = value!;
                        context.setLocale(const Locale('ar'));
                      });
                    },
                  ),
                ],
              ),
              SizedBox(height: 20.h),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    Theme.of(context).brightness == Brightness.dark
                        ? "dark_theme".tr()
                        : "light_theme".tr(),
                    style: TextStyle(color: Theme.of(context).textTheme.bodyLarge?.color),
                  ),
                  SizedBox(width: 10.w),
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
            ],
          ),
        ),
      ),
      )
    );
  }
}
