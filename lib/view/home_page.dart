import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:log/view/cart.dart';
import 'package:log/widgets/best_price.dart';
import 'package:log/widgets/places.dart';

import '../widgets/BestPriceListView.dart';
import '../widgets/categoryContainer.dart';
import 'datailsPage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  // final List<Map<String, String>> bestPrices = [
  //   {
  //     "image": "assets/images/BestPrice/cheesecake.webp",
  //     "name": "Latte",
  //     "price": "\$2.00",
  //   },
  //   {
  //     "image": "assets/images/BestPrice/Cappuccino.jpg",
  //     "name": "Nordic tea",
  //     "price": "\$1.80",
  //   },
  //   {
  //     "image": "assets/images/BestPrice/MangoJuice.jpg",
  //     "name": "Matcha latte",
  //     "price": "\$1.95",
  //   },
  // ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: EdgeInsets.only(top: 8.0.h),
          child: Text("Regent Street, 16", style: TextStyle(fontSize: 28.sp)),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon:  Icon(Icons.keyboard_arrow_down, size: 30.sp),
          ),
        ],
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(18.r),
          child: Column(
            children: [
              SizedBox(
                height: 250,
                child: GridView(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                    childAspectRatio: 1,
                  ),
                  children: [
                    CustomGridItem(
                      color: Colors.orange,
                      text: "Specials of the week",
                      imagePath: 'assets/images/categories/discount.png',
                      textColor: Colors.white,
                    ),
                    CustomGridItem(
                      color: Colors.pink[50]!,
                      text: "Cookies",
                      imagePath: 'assets/images/categories/cookies.png',
                      textColor: Colors.black,
                    ),
                    CustomGridItem(
                      color: Colors.pink[50]!,
                      text: "Drinks",
                      imagePath: 'assets/images/categories/colawater.png',
                      textColor: Colors.black,
                    ),
                    CustomGridItem(
                      color: Colors.pink[50]!,
                      text: "Deserts",
                      imagePath: 'assets/images/categories/desert.png',
                      textColor: Colors.black,
                    ),
                    CustomGridItem(
                      color: Colors.pink[50]!,
                      text: "Pizza",
                      imagePath: 'assets/images/categories/pizzaa.png',
                      textColor: Colors.black,
                    ),
                    CustomGridItem(
                      color: Colors.pink[50]!,
                      text: "salads",
                      imagePath: 'assets/images/categories/salad.png',
                      textColor: Colors.black,
                    ),
                  ],
                ),
              ),

              Align(
                alignment: Alignment.centerLeft,
                child: Text("Places", style: TextStyle(fontSize: 25.sp)),
              ),

              SizedBox(height: 15.h),
              SizedBox(
                height: 200.h,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    PlaceCard(
                      name: "Sundown cafe",
                      image: 'assets/images/places/restaurant.jpg',
                      rating: 4.9,
                      time: " 60 min",
                      type: "Italian food .",
                    ),
                    PlaceCard(
                      name: "The cozy cup",
                      image: 'assets/images/places/lounge.jpg',
                      rating: 4.9,
                      time: " 35 min",
                      type: "Breakfast coffee .",
                    ),
                  ],
                ),
              ),

              SizedBox(height: 15.h),
              Align(
                alignment: Alignment.centerLeft,
                child: Row(
                  children: [
                    Text("Best prices", style: TextStyle(fontSize: 25.sp)),
                    SizedBox(width: 10.w),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 6.w,
                        vertical: 2.h,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(100.r),
                      ),
                      child: Text(
                        "%",
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
        selectedItemColor: Colors.orange,
        unselectedItemColor: Colors.black,

        onTap: (index) {
          if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => CartPage()),
            );
          }
        },

        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: "Catalog"),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart_outlined),
            label: "Cart",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline_outlined),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}
