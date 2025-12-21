import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:log/cubit/dart/category_cubit.dart';
import 'package:log/view/cart.dart';
import 'package:log/view/profile.dart';
import 'package:log/widgets/places.dart';
import '../cubit/dart/category_state.dart';
import '../widgets/BestPriceListView.dart';
import '../widgets/categoryContainer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 0,
        iconTheme: IconThemeData(color: Theme.of(context).iconTheme.color),
        title: Padding(
          padding: EdgeInsets.only(top: 8.0.h),
          child: Text(
            "Regent_Street,_16".tr(),
            style: TextStyle(
              fontSize: 28.sp,
              color: Theme.of(context).appBarTheme.titleTextStyle?.color,
            ),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.keyboard_arrow_down, size: 30.sp, color: Theme.of(context).iconTheme.color),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(18.r),
          child: Column(
            children: [
              SizedBox(
                height: 250.h,
                child: BlocBuilder<CategoryCubit,CategoryState>(
                    builder: (context,state){
                      final cubit = context.read<CategoryCubit>();
                      return GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: state.categories.length,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 8,
                            mainAxisSpacing: 8,
                            childAspectRatio: 1,
                          ),
                          itemBuilder: (context,index){
                            final item = state.categories[index];
                            final isSelected = cubit.selectedIndex == index;
                            return GestureDetector(
                              onTap: () {
                                cubit.selectIndex(index);
                              },
                              child: CustomGridItem(

                                text: item["text"],
                                imagePath: item["image"],
                                isSpecial: item["isSpecial"] ?? false,
                                isSelected: isSelected,
                              ),
                            );

                          });
                      
                    }),
              ),
              Align(
                alignment: AlignmentDirectional.centerStart,
                child: Text(
                  "places".tr(),
                  style: TextStyle(
                    fontSize: 25.sp,
                    color: Theme.of(context).textTheme.bodyLarge?.color,
                  ),
                ),
              ),
              SizedBox(height: 15.h),
              SizedBox(
                height: 200.h,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    PlaceCard(
                      name: "sundown_cafe".tr(),
                      image: 'assets/images/places/restaurant.jpg',
                      rating: 4.9,
                      time: "60_min".tr(),
                      type: "italian_food".tr(),
                    ),
                    PlaceCard(
                      name: "the_cozy_cup".tr(),
                      image: 'assets/images/places/lounge.jpg',
                      rating: 4.9,
                      time: "35_min".tr(),
                      type: "breakfast_coffee".tr(),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 15.h),
              Align(
                alignment: Alignment.centerLeft,
                child: Row(
                  children: [
                    Text(
                      "best_prices".tr(),
                      style: TextStyle(
                        fontSize: 25.sp,
                        color: Theme.of(context).textTheme.bodyLarge?.color,
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(100.r),
                      ),
                      child: Text(
                        "%".tr(),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 15.h),
              BestPriceList(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        showUnselectedLabels: true,
        currentIndex: _selectedIndex,
        selectedItemColor: Theme.of(context).bottomNavigationBarTheme.selectedItemColor,
        unselectedItemColor: Theme.of(context).bottomNavigationBarTheme.unselectedItemColor,
        backgroundColor: Theme.of(context).bottomNavigationBarTheme.backgroundColor,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
          if (index == 2) {
            Navigator.push(context, MaterialPageRoute(builder: (_) => CartPage()));
          } else if (index == 3) {
            Navigator.push(context, MaterialPageRoute(builder: (_) => Profile()));
          }
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "home".tr()),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: "catalog".tr()),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart_outlined), label: "cart".tr()),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline_outlined), label: "profile".tr()),
        ],
      ),
    );
  }
}
