import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notch_r_shop_provider/screen/cart_screen.dart';
import 'package:notch_r_shop_provider/constant/app_color.dart';
import 'package:notch_r_shop_provider/screen/sign_in_screen.dart';
import 'package:notch_r_shop_provider/constant/responsiveness.dart';
import 'package:notch_r_shop_provider/screen/favourite_screen.dart';
import 'package:notch_r_shop_provider/provider/r_notch_provider.dart';

class DrawerScreen extends StatelessWidget {
  const DrawerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductProvider>(
      builder: (context, value, child) {
        return Drawer(
          backgroundColor: value.isDark
              ? const Color(0xFF1E1E1E)
              : Colors.white,
          child: Column(
            children: [
              Container(
                height: context.notchHeight * 0.30,
                width: double.infinity,
                decoration: BoxDecoration(color: AppColors.mainAppColor),
                child: SafeArea(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: context.notchWidth * 0.05),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(width: context.notchWidth * 0.10),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: context.notchWidth * 0.10,
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.white,
                                  width: context.notchWidth * 0.008,
                                ),
                              ),
                              child: CircleAvatar(
                                radius: context.notchWidth * 0.12,
                                backgroundImage: const AssetImage(
                                  'assets/rehan.png',
                                ),
                              ),
                            ),
                          ),

                          // SizedBox(width: context.notchWidth * 0.10,),
                          GestureDetector(
                            onTap: () {
                              value.isDarkMode();
                              value.darkModeSave();
                            },
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 250),
                              padding: EdgeInsets.symmetric(
                                horizontal: context.notchWidth * 0.02,
                                vertical: context.notchHeight * 0.007,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.15),
                                borderRadius: BorderRadius.circular(
                                  context.notchWidth * 0.03,
                                ),
                                border: Border.all(
                                  color: Colors.white24,
                                  width: 1,
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    value.isDark
                                        ? Icons.light_mode_rounded
                                        : Icons.dark_mode_rounded,
                                    color: Colors.white,
                                    size: context.notchWidth * 0.05,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: context.notchHeight * 0.010),

                      Text(
                        'Khan Rehan',
                        style: GoogleFonts.pacifico(
                          color: Colors.white,
                          fontSize: context.notchWidth * 0.060,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: context.notchHeight * 0.002),

                      Text(
                        value.emailStore,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: ListTile(
                  leading: Icon(Icons.home, color: AppColors.mainAppColor),
                  title: Text(
                    'Home',
                    style: TextStyle(
                      fontSize: context.notchWidth * 0.05,
                      fontWeight: FontWeight.w600,
                      color: value.isDark ? Colors.white : Colors.black,
                    ),
                  ),
                ),
              ),

              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,

                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          CartScreen(),

                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                            return FadeTransition(
                              opacity: animation,
                              child: child,
                            );
                          },
                    ),
                  );
                },
                child: ListTile(
                  leading: Icon(
                    Icons.shopping_cart,
                    color: AppColors.mainAppColor,
                  ),
                  title: Text(
                    'My Cart',
                    style: TextStyle(
                      fontSize: context.notchWidth * 0.05,
                      fontWeight: FontWeight.w600,
                      color: value.isDark ? Colors.white : Colors.black,
                    ),
                  ),
                ),
              ),

              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,

                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          FavouriteScreen(),

                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                            return FadeTransition(
                              opacity: animation,
                              child: child,
                            );
                          },
                    ),
                  );
                },
                child: ListTile(
                  leading: Icon(Icons.favorite, color: AppColors.mainAppColor),
                  title: Text(
                    'Favorite',
                    style: TextStyle(
                      fontSize: context.notchWidth * 0.05,
                      fontWeight: FontWeight.w600,
                      color: value.isDark ? Colors.white : Colors.black,
                    ),
                  ),
                ),
              ),

              Divider(color: value.isDark ? Colors.white24 : Colors.black12),

              ListTile(
                leading: Icon(Icons.help, color: AppColors.mainAppColor),
                title: Text(
                  'Help & Support',
                  style: TextStyle(
                    fontSize: context.notchWidth * 0.05,
                    fontWeight: FontWeight.w600,
                    color: value.isDark ? Colors.white : Colors.black,
                  ),
                ),
              ),

              GestureDetector(
                onTap: () {
                  if (value.isLogin == true) {
                    value.isLogin = false;
                    value.loginSave();
                    Navigator.pop(context);
                    Navigator.pushReplacement(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            SignInScreen(),

                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
                              return FadeTransition(
                                opacity: animation,
                                child: child,
                              );
                            },
                      ),
                    );
                  }
                },
                child: ListTile(
                  leading: Icon(Icons.logout, color: AppColors.mainAppColor),
                  title: Text(
                    'Logout',
                    style: TextStyle(
                      fontSize: context.notchWidth * 0.05,
                      fontWeight: FontWeight.w600,
                      color: value.isDark ? Colors.white : Colors.black,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
