import 'package:flutter/material.dart';
import 'package:notch_r_shop_provider/screen/cart_screen.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notch_r_shop_provider/constant/app_color.dart';
import 'package:notch_r_shop_provider/screen/home_screen.dart';
import 'package:notch_r_shop_provider/constant/responsiveness.dart';
import 'package:notch_r_shop_provider/provider/r_notch_provider.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final providerWatch = context.watch<ProductProvider>();

    return Scaffold(
      backgroundColor: providerWatch.isDark
          ? const Color(0xFF121212)
          : Colors.white,
      appBar: AppBar(
        backgroundColor: AppColors.mainAppColor,
        title: Text(
          'Favourites',
          style: GoogleFonts.pacifico(
            color: AppColors.appBackgroundColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),

      body: providerWatch.favourites.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.favorite_border,
                    size: 80,
                    color: providerWatch.isDark
                        ? Colors.red.shade300
                        : Colors.red.shade100,
                  ),

                  const SizedBox(height: 16),

                  Text(
                    'No favorites yet',

                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: providerWatch.isDark
                          ? Colors.white
                          : Colors.grey.shade700,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    'Save products you love ❤️',

                    style: TextStyle(
                      fontSize: 14,
                      color: providerWatch.isDark
                          ? Colors.white70
                          : Colors.grey.shade500,
                    ),
                  ),

                  const SizedBox(height: 24),

                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,

                        PageRouteBuilder(
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  HomeScreen(),

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

                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF6C63FF),

                      foregroundColor: Colors.white,

                      padding: const EdgeInsets.symmetric(
                        horizontal: 28,
                        vertical: 14,
                      ),

                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),

                    child: const Text(
                      'Explore Products',

                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            )
          : Consumer<ProductProvider>(
              builder: (context, value, child) {
                return ListView.builder(
                  physics: BouncingScrollPhysics(),
                  itemCount: value.favourites.length,

                  itemBuilder: (context, index) {
                    final item = value.favourites[index];

                    return Dismissible(
                      key: ObjectKey(item),

                      direction: DismissDirection.endToStart,

                      background: Container(
                        alignment: Alignment.centerRight,

                        padding: EdgeInsets.only(
                          right: context.notchWidth * 0.06,
                        ),

                        decoration: BoxDecoration(
                          color: Colors.red.shade400,

                          borderRadius: BorderRadius.circular(
                            context.notchWidth * 0.05,
                          ),
                        ),

                        child: Icon(
                          Icons.favorite,
                          color: Colors.white,
                          size: context.notchWidth * 0.07,
                        ),
                      ),

                      onDismissed: (_) {
                        value.removeFavourite(index);
                        value.isFavouriteSelected(item);
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: context.notchWidth * 0.04,
                          vertical: context.notchHeight * 0.01,
                        ),

                        child: Card(
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              context.notchWidth * 0.05,
                            ),
                            side: BorderSide(
                              color: providerWatch.isDark
                                  ? Colors.white24
                                  : Colors.grey.shade100,
                            ),
                          ),
                          color: providerWatch.isDark
                              ? const Color(0xFF1E1E1E)
                              : Colors.white,

                          child: Padding(
                            padding: EdgeInsets.all(context.notchWidth * 0.03),

                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(
                                    context.notchWidth * 0.04,
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: context.notchWidth * 0.015,
                                    ),
                                    child: Image.network(
                                      item.image,
                                      height: context.notchHeight * 0.15,
                                      width: context.notchWidth * 0.20,
                                      fit: BoxFit.contain,
                                      errorBuilder: (_, __, ___) => Container(
                                        height: context.notchHeight * 0.10,
                                        width: context.notchWidth * 0.20,
                                        color: providerWatch.isDark
                                            ? const Color(0xFF2A2A2A)
                                            : Colors.grey.shade100,
                                        child: Icon(
                                          Icons.image_not_supported,
                                          color: providerWatch.isDark
                                              ? Colors.white54
                                              : Colors.black54,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),

                                SizedBox(width: context.notchWidth * 0.03),

                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: context.notchWidth * 0.025,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          item.title,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize:
                                                context.notchWidth * 0.037,
                                            color: providerWatch.isDark
                                                ? Colors.white
                                                : Colors.black,
                                          ),
                                        ),

                                        Text(
                                          'Sold by R Notch Codeilm',
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: GoogleFonts.daiBannaSil(
                                            fontWeight: FontWeight.w600,
                                            color: providerWatch.isDark
                                                ? Colors.white70
                                                : Colors.grey.shade500,
                                            fontSize:
                                                context.notchWidth * 0.037,
                                          ),
                                        ),

                                        SizedBox(
                                          height: context.notchHeight * 0.005,
                                        ),

                                        Text(
                                          '\$${item.price.toStringAsFixed(2)}',
                                          style: TextStyle(
                                            fontSize:
                                                context.notchWidth * 0.037,
                                            color: Colors.green.shade700,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),

                                        SizedBox(
                                          height: context.notchHeight * 0.005,
                                        ),

                                        SizedBox(
                                          height: context.notchHeight * 0.045,
                                          width: context.notchWidth * 0.500,
                                          child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  AppColors.mainAppColor,
                                            ),

                                            onPressed: () {
                                              if (item.buttonName ==
                                                  'Add to Cart') {
                                                value.addToCart(item);
                                                value.changeButtonName(
                                                  'Go to bag',
                                                  item,
                                                );
                                              } else {
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
                                              }
                                            },

                                            child: Text(
                                              item.buttonName,
                                              style: TextStyle(
                                                fontSize:
                                                    context.notchWidth * 0.038,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),

                                        SizedBox(
                                          height: context.notchHeight * 0.005,
                                        ),

                                        Text(
                                          '7 days return available',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize:
                                                context.notchWidth * 0.040,
                                            color: providerWatch.isDark
                                                ? Colors.white70
                                                : Colors.grey.shade600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),

                                Padding(
                                  padding: EdgeInsets.only(
                                    bottom: context.notchHeight * 0.13,
                                  ),

                                  child: GestureDetector(
                                    onTap: () {
                                      value.isFavouriteSelected(item);
                                      value.removeFavourite(index);
                                    },
                                    child: Icon(
                                      item.favourite
                                          ? Icons.favorite
                                          : Icons.favorite_border,
                                      color: item.favourite
                                          ? Colors.red
                                          : providerWatch.isDark
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}
