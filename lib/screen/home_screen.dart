import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:badges/badges.dart' as badges;
import 'package:google_fonts/google_fonts.dart';
import 'package:notch_r_shop_provider/constant/app_color.dart';
import 'package:notch_r_shop_provider/screen/cart_screen.dart';
import 'package:notch_r_shop_provider/screen/drawer_screen.dart';
import 'package:notch_r_shop_provider/constant/responsiveness.dart';
import 'package:notch_r_shop_provider/screen/favourite_screen.dart';
import 'package:notch_r_shop_provider/provider/r_notch_provider.dart';
import 'package:notch_r_shop_provider/widgets/text_field_custom.dart';
import 'package:notch_r_shop_provider/widgets/home_chip_selector.dart';
import 'package:notch_r_shop_provider/widgets/show_model_bottom_sheet.dart';
import 'package:notch_r_shop_provider/widgets/build_product_list_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<ProductProvider>().getCounter();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductProvider>(
      builder: (context, value, child) {
        return GestureDetector(
          onTap: (){
             FocusScope.of(context).unfocus();
          },
          child: Scaffold(
            backgroundColor: value.isDark
                ? const Color(0xFF121212)
                : Colors.white,
          
            drawer: DrawerScreen(),
          
            appBar: AppBar(
              backgroundColor: AppColors.mainAppColor,
              title: Text(
                'R Notch Shop',
                style: GoogleFonts.pacifico(
                  color: AppColors.appBackgroundColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              centerTitle: true,
              actions: [
                Consumer<ProductProvider>(
                  builder: (context, value, child) {
                    return Row(
                      children: [
                        value.favourites.isEmpty
                            ? GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
          
                                    PageRouteBuilder(
                                      pageBuilder:
                                          (
                                            context,
                                            animation,
                                            secondaryAnimation,
                                          ) => FavouriteScreen(),
          
                                      transitionsBuilder:
                                          (
                                            context,
                                            animation,
                                            secondaryAnimation,
                                            child,
                                          ) {
                                            return FadeTransition(
                                              opacity: animation,
                                              child: child,
                                            );
                                          },
                                    ),
                                  );
                                },
                                child: Icon(Icons.favorite_border),
                              )
                            : badges.Badge(
                                badgeContent: Text(
                                  '${value.favourites.length}',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),
                                ),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
          
                                      PageRouteBuilder(
                                        pageBuilder:
                                            (
                                              context,
                                              animation,
                                              secondaryAnimation,
                                            ) => FavouriteScreen(),
          
                                        transitionsBuilder:
                                            (
                                              context,
                                              animation,
                                              secondaryAnimation,
                                              child,
                                            ) {
                                              return FadeTransition(
                                                opacity: animation,
                                                child: child,
                                              );
                                            },
                                      ),
                                    );
                                  },
                                  child: Icon(Icons.favorite_border),
                                ),
                              ),
          
                        SizedBox(width: context.notchWidth * 0.050),
          
                        value.cartItems.isNotEmpty
                            ? badges.Badge(
                                badgeContent: Text(
                                  '${value.cartItems.length}',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),
                                ),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
          
                                      PageRouteBuilder(
                                        pageBuilder:
                                            (
                                              context,
                                              animation,
                                              secondaryAnimation,
                                            ) => CartScreen(),
          
                                        transitionsBuilder:
                                            (
                                              context,
                                              animation,
                                              secondaryAnimation,
                                              child,
                                            ) {
                                              return FadeTransition(
                                                opacity: animation,
                                                child: child,
                                              );
                                            },
                                      ),
                                    );
                                  },
                                  child: Icon(Icons.shopping_cart),
                                ),
                              )
                            : GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
          
                                    PageRouteBuilder(
                                      pageBuilder:
                                          (
                                            context,
                                            animation,
                                            secondaryAnimation,
                                          ) => CartScreen(),
          
                                      transitionsBuilder:
                                          (
                                            context,
                                            animation,
                                            secondaryAnimation,
                                            child,
                                          ) {
                                            return FadeTransition(
                                              opacity: animation,
                                              child: child,
                                            );
                                          },
                                    ),
                                  );
                                },
                                child: Icon(Icons.shopping_cart),
                              ),
                        SizedBox(width: context.notchWidth * 0.050),
                      ],
                    );
                  },
                ),
              ],
            ),
            body: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(context.notchHeight * 0.013),
                  height: context.notchHeight * 0.08,
                  color: value.isDark ? const Color(0xFF1E1E1E) : Colors.white,
                  child: Consumer<ProductProvider>(
                    builder: (context, value, child) {
                      return ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          HomeChipSelector(
                            title: 'All',
                            select: value.select == 'All' ? 'select' : '',
                            onTap: () {
                              value.selectCategory('All');
                              value.selectCategoryWithApi();
                              value.categorySave();
                            },
                          ),
          
                          HomeChipSelector(
                            title: 'Men\'s',
                            select: value.select == 'Men\'s' ? 'select' : '',
                            onTap: () {
                              value.selectCategory('Men\'s');
                              value.selectCategoryWithApi();
                              value.categorySave();
                            },
                          ),
          
                          HomeChipSelector(
                            title: 'Women\'s',
                            select: value.select == 'Women\'s' ? 'select' : '',
                            onTap: () {
                              value.selectCategory('Women\'s');
                              value.selectCategoryWithApi();
                              value.categorySave();
                            },
                          ),
          
                          HomeChipSelector(
                            title: 'Jewelery',
                            select: value.select == 'Jewelery' ? 'select' : '',
                            onTap: () {
                              value.selectCategory('Jewelery');
                              value.selectCategoryWithApi();
                              value.categorySave();
                            },
                          ),
          
                          HomeChipSelector(
                            title: 'Electronics',
                            select: value.select == 'Electronics' ? 'select' : '',
                            onTap: () {
                              value.selectCategory('Electronics');
                              value.selectCategoryWithApi();
                              value.categorySave();
                            },
                          ),
                        ],
                      );
                    },
                  ),
                ),
                SizedBox(height: context.notchHeight * 0.010),
                ShowModelBottomSheet(),
                TextFieldCustom(),
                Expanded(child: BuildProductListView()),
              ],
            ),
          ),
        );
      },
    );
  }
}
