import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:notch_r_shop_provider/constant/app_color.dart';
import 'package:notch_r_shop_provider/screen/cart_screen.dart';
import 'package:notch_r_shop_provider/screen/info_screen.dart';
import 'package:notch_r_shop_provider/constant/responsiveness.dart';
import 'package:notch_r_shop_provider/provider/r_notch_provider.dart';

class BuildProductListView extends StatelessWidget {
  const BuildProductListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductProvider>(
      builder: (context, value, child) {
        return value.isLoading
            ? Center(
                child: CircularProgressIndicator(color: AppColors.mainAppColor),
              )
            : ListView.separated(
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                physics: BouncingScrollPhysics(),
                padding: EdgeInsets.only(bottom: context.notchHeight * 0.015),
                itemCount: value.filteredList.length,
                separatorBuilder: (context, index) =>
                    SizedBox(height: context.notchHeight * 0.015),
                itemBuilder: (context, index) {
                  final item = value.filteredList[index];
                  return Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: context.notchHeight * 0.015,
                    ),
                    child: GestureDetector(
                      onTap: () {
                        value.similarProductSearching(item);
                        Navigator.push(
                          context,

                          PageRouteBuilder(
                            pageBuilder:
                                (context, animation, secondaryAnimation) =>
                                    ProductDetailsScreen(product: item),

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
                      child: Container(
                        decoration: BoxDecoration(
                          color: value.isDark
                              ? const Color(0xFF1E1E1E)
                              : Colors.white,
                          borderRadius: BorderRadius.circular(
                            context.notchHeight * 0.01,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: value.isDark
                                  ? Colors.black54
                                  : Colors.black12,
                              blurRadius: 4,
                              offset: Offset(2, 2),
                            ),
                          ],
                        ),
                        height: context.notchHeight * 0.175,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: context.notchWidth * 0.015,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              SizedBox(height: context.notchHeight * 0.010),

                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                    width: context.notchWidth * 0.33,
                                    height: context.notchHeight * 0.16,
                                    padding: EdgeInsets.all(
                                      context.notchWidth * 0.02,
                                    ),
                                    child: Image.network(
                                      item.image,
                                      fit: BoxFit.contain,
                                    ),
                                  ),

                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: context.notchWidth * 0.028,
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            item.title,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize:
                                                  context.notchWidth * 0.045,
                                              color: value.isDark
                                                  ? Colors.white
                                                  : Colors.black54,
                                            ),
                                          ),

                                          SizedBox(
                                            height: context.notchWidth * 0.012,
                                          ),

                                          Text(
                                            '\$${item.price}',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize:
                                                  context.notchWidth * 0.045,
                                              color: Colors.green,
                                            ),
                                          ),

                                          RatingBarIndicator(
                                            rating: item.rating.rate.toDouble(),

                                            itemBuilder: (context, index) =>
                                                Icon(
                                                  Icons.star,
                                                  color: Colors.amber,
                                                  size:
                                                      context.notchWidth *
                                                      0.030,
                                                ),

                                            itemCount: 5,

                                            itemSize: context.notchWidth * 0.05,

                                            direction: Axis.horizontal,
                                          ),

                                          SizedBox(
                                            height: context.notchWidth * 0.01,
                                          ),

                                          SizedBox(
                                            width: context.notchWidth * 0.48,

                                            child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor:
                                                    AppColors.mainAppColor,
                                              ),

                                              onPressed: () {
                                                if (item.buttonName ==
                                                    'Add to Cart') {
                                                  value.changeButtonName(
                                                    'Go to bag',
                                                    item,
                                                  );
                                                  value.addToCart(item);
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
                                                              opacity:
                                                                  animation,
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
                                                      context.notchWidth *
                                                      0.045,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),

                                  Padding(
                                    padding: EdgeInsets.only(
                                      bottom: context.notchHeight * 0.125,
                                    ),
                                    child: GestureDetector(
                                      onTap: () {
                                        value.isFavouriteSelected(item);
                                        value.addToFavourite(item);
                                      },
                                      child: Icon(
                                        item.favourite
                                            ? Icons.favorite
                                            : Icons.favorite_border,
                                        color: item.favourite
                                            ? Colors.red
                                            : value.isDark
                                            ? Colors.white
                                            : Colors.black,
                                        size: context.notchWidth * 0.06,
                                      ),
                                    ),
                                  ),
                                ],
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
    );
  }
}
