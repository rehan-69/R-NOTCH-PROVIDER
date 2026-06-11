import 'package:flutter/material.dart';
import 'provider/r_notch_provider.dart';
import 'package:provider/provider.dart';
import 'package:notch_r_shop_provider/screen/home_screen.dart';
import 'package:notch_r_shop_provider/screen/sign_in_screen.dart';

class RNotchApp extends StatelessWidget {
  const RNotchApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ProductProvider(),
      child: Consumer<ProductProvider>(
        builder: (context, value, child) {
          return MaterialApp(
            
            theme: ThemeData.light().copyWith(
              appBarTheme: const AppBarTheme(
                iconTheme: IconThemeData(color: Colors.white),
              ),
            ),

            darkTheme: ThemeData.dark().copyWith(
              appBarTheme: const AppBarTheme(
                iconTheme: IconThemeData(color: Colors.white),
              ),
            ),

            themeMode: value.isDark ? ThemeMode.dark : ThemeMode.light,
            debugShowCheckedModeBanner: false,
            home: value.isLogin == true ? HomeScreen() : SignInScreen(),
          );
        },
      ),
    );
  }
}
