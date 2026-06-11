import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:notch_r_shop_provider/constant/app_color.dart';
import 'package:notch_r_shop_provider/screen/cart_screen.dart';
import 'package:notch_r_shop_provider/model/product_model.dart';
import 'package:notch_r_shop_provider/constant/responsiveness.dart';
import 'package:notch_r_shop_provider/provider/r_notch_provider.dart';

class ProductDetailsScreen extends StatelessWidget {
  final Product product;
  const ProductDetailsScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductProvider>(
      builder: (context, value, child) {
        return Scaffold(
          backgroundColor: value.isDark
              ? const Color(0xFF121212)
              : Colors.white,
          appBar: AppBar(
            backgroundColor: AppColors.mainAppColor,
            title: Text(
              'Product Overview',
              style: GoogleFonts.pacifico(
                color: AppColors.appBackgroundColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            centerTitle: true,
          ),
          body: Column(
            children: [
              Stack(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: context.notchHeight * 0.030),
                    child: Image.network(
                      product.image,
                      height: context.notchHeight * 0.33,
                      width: context.notchWidth * 0.85,
                    ),
                  ),
                  Positioned(
                    top: context.notchHeight * 0.020,
                    right: context.notchWidth * 0.010,
                    child: GestureDetector(
                      onTap: () {
                        value.isFavouriteSelected(product);
                        value.addToFavourite(product);
                      },
                      child: Icon(
                        product.favourite
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: product.favourite
                            ? Colors.red
                            : value.isDark
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: context.notchHeight * 0.025),
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: value.isDark
                        ? const Color(0xFF1E1E1E)
                        : const Color(0xFFF8F9FA),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(context.notchWidth * 0.08),
                      topRight: Radius.circular(context.notchWidth * 0.08),
                    ),
                  ),
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: context.notchHeight * 0.032),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: context.notchWidth * 0.06,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: context.notchWidth * 0.035,
                                  vertical: context.notchHeight * 0.008,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.mainAppColor.withOpacity(
                                    0.08,
                                  ),
                                  borderRadius: BorderRadius.circular(100),
                                  border: Border.all(
                                    color: AppColors.mainAppColor.withOpacity(
                                      0.15,
                                    ),
                                    width: 1,
                                  ),
                                ),
                                child: Text(
                                  product.category.toUpperCase(),
                                  style: TextStyle(
                                    fontSize: context.notchWidth * 0.03,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.mainAppColor,
                                    letterSpacing: 1.2,
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: context.notchWidth * 0.03,
                                  vertical: context.notchHeight * 0.006,
                                ),
                                decoration: BoxDecoration(
                                  color: product.rating.count > 0
                                      ? const Color(0xFFE6F4EA)
                                      : const Color(0xFFFCE8E6),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 6,
                                      height: 6,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: product.rating.count > 0
                                            ? const Color(0xFF137333)
                                            : const Color(0xFFC5221F),
                                      ),
                                    ),
                                    SizedBox(width: context.notchWidth * 0.015),
                                    Text(
                                      product.rating.count > 0
                                          ? '${product.rating.count} AVAILABLE'
                                          : 'OUT OF STOCK',
                                      style: TextStyle(
                                        color: product.rating.count > 0
                                            ? const Color(0xFF137333)
                                            : const Color(0xFFC5221F),
                                        fontSize: context.notchWidth * 0.028,
                                        fontWeight: FontWeight.w700,
                                        letterSpacing: 0.5,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: context.notchHeight * 0.02),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: context.notchWidth * 0.06,
                          ),
                          child: Text(
                            product.title,
                            maxLines: 2,
                            softWrap: true,
                            style: TextStyle(
                              fontSize: context.notchWidth * 0.064,
                              fontWeight: FontWeight.w900,
                              color: value.isDark
                                  ? Colors.white
                                  : const Color(0xFF1A1A1A),
                              height: 1.25,
                              letterSpacing: -0.5,
                            ),
                          ),
                        ),
                        SizedBox(height: context.notchHeight * 0.024),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: context.notchWidth * 0.06,
                          ),
                          child: Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(context.notchWidth * 0.045),
                            decoration: BoxDecoration(
                              color: value.isDark
                                  ? const Color(0xFF2A2A2A)
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(24),
                              boxShadow: [
                                BoxShadow(
                                  color: value.isDark
                                      ? Colors.black54
                                      : const Color(
                                          0xFF000000,
                                        ).withOpacity(0.03),
                                  blurRadius: 20,
                                  offset: const Offset(0, 8),
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'TOTAL PRICE',
                                      style: TextStyle(
                                        color: value.isDark
                                            ? Colors.white70
                                            : const Color(0xFF8E8E93),
                                        fontSize: context.notchWidth * 0.028,
                                        fontWeight: FontWeight.w600,
                                        letterSpacing: 0.8,
                                      ),
                                    ),
                                    SizedBox(
                                      height: context.notchHeight * 0.004,
                                    ),
                                    Text(
                                      '\$${product.price}',
                                      style: TextStyle(
                                        color: value.isDark
                                            ? Colors.white
                                            : const Color(0xFF1A1A1A),
                                        fontSize: context.notchWidth * 0.068,
                                        fontWeight: FontWeight.w800,
                                        letterSpacing: -0.5,
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: context.notchWidth * 0.035,
                                    vertical: context.notchHeight * 0.01,
                                  ),
                                  decoration: BoxDecoration(
                                    color: value.isDark
                                        ? const Color(0xFF3A3A3A)
                                        : const Color(0xFFF8F9FA),
                                    borderRadius: BorderRadius.circular(14),
                                  ),
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.star_rounded,
                                        color: Color(0xFFFFB300),
                                        size: 20,
                                      ),
                                      SizedBox(
                                        width: context.notchWidth * 0.01,
                                      ),
                                      Text(
                                        '${product.rating.rate.toDouble()}',
                                        style: TextStyle(
                                          color: value.isDark
                                              ? Colors.white
                                              : const Color(0xFF1A1A1A),
                                          fontSize: context.notchWidth * 0.036,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: context.notchHeight * 0.032),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: context.notchWidth * 0.06,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'DESCRIPTION',
                                style: TextStyle(
                                  color: value.isDark
                                      ? Colors.white70
                                      : const Color(0xFF8E8E93),
                                  fontSize: context.notchWidth * 0.03,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 1.0,
                                ),
                              ),
                              SizedBox(height: context.notchHeight * 0.012),
                              Text(
                                product.description,
                                textAlign: TextAlign.justify,
                                style: TextStyle(
                                  fontSize: context.notchWidth * 0.038,
                                  color: value.isDark
                                      ? Colors.white70
                                      : const Color(0xFF4A4A4A),
                                  height: 1.6,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: context.notchHeight * 0.04),
                        GestureDetector(
                          onTap: () {
                            if (product.buttonName == 'Add to Cart') {
                              value.addToCart(product);
                              value.changeButtonName('Go to bag', product);
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
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: context.notchWidth * 0.06,
                            ),
                            child: Container(
                              height: context.notchHeight * 0.068,
                              decoration: BoxDecoration(
                                color: AppColors.mainAppColor,
                                borderRadius: BorderRadius.circular(18),
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColors.mainAppColor.withOpacity(
                                      0.25,
                                    ),
                                    blurRadius: 24,
                                    offset: const Offset(0, 8),
                                  ),
                                ],
                              ),
                              child: Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      product.buttonName == 'Add to Cart'
                                          ? Icons.shopping_bag_outlined
                                          : Icons.arrow_forward_rounded,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                    SizedBox(width: context.notchWidth * 0.024),
                                    Text(
                                      product.buttonName.toUpperCase(),
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: context.notchWidth * 0.038,
                                        fontWeight: FontWeight.w700,
                                        letterSpacing: 1.0,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: context.notchHeight * 0.048),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: context.notchWidth * 0.06,
                          ),
                          child: Text(
                            'YOU MAY ALSO LIKE',
                            style: TextStyle(
                              fontSize: context.notchWidth * 0.03,
                              fontWeight: FontWeight.w700,
                              color: value.isDark
                                  ? Colors.white70
                                  : const Color(0xFF8E8E93),
                              letterSpacing: 1.0,
                            ),
                          ),
                        ),
                        SizedBox(height: context.notchHeight * 0.016),
                        SizedBox(
                          height: context.notchHeight * 0.38,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            physics: const BouncingScrollPhysics(),
                            itemCount: value.similarProductStore.length,
                            padding: EdgeInsets.only(
                              left: context.notchWidth * 0.06,
                              right: context.notchWidth * 0.06,
                              bottom: context.notchHeight * 0.03,
                            ),
                            itemBuilder: (context, index) {
                              final item = value.similarProductStore[index];
                              return GestureDetector(
                                onTap: () {
                                  value.similarProductSearching(item);
                                  Navigator.push(
                                    context,

                                    PageRouteBuilder(
                                      pageBuilder:
                                          (
                                            context,
                                            animation,
                                            secondaryAnimation,
                                          ) => ProductDetailsScreen(
                                            product: item,
                                          ),

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
                                  width: context.notchWidth * 0.52,
                                  margin: EdgeInsets.only(
                                    right: context.notchWidth * 0.04,
                                  ),
                                  decoration: BoxDecoration(
                                    color: value.isDark
                                        ? const Color(0xFF2A2A2A)
                                        : Colors.white,
                                    borderRadius: BorderRadius.circular(24),
                                    boxShadow: [
                                      BoxShadow(
                                        color: value.isDark
                                            ? Colors.black54
                                            : const Color(
                                                0xFF000000,
                                              ).withOpacity(0.03),
                                        blurRadius: 16,
                                        offset: const Offset(0, 6),
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Stack(
                                          children: [
                                            Container(
                                              margin: EdgeInsets.all(
                                                context.notchWidth * 0.03,
                                              ),
                                              decoration: BoxDecoration(
                                                color: value.isDark
                                                    ? const Color(0xFF3A3A3A)
                                                    : const Color(0xFFF8F9FA),
                                                borderRadius:
                                                    BorderRadius.circular(18),
                                              ),
                                              padding: EdgeInsets.all(
                                                context.notchWidth * 0.04,
                                              ),
                                              width: double.infinity,
                                              child: Image.network(
                                                item.image,
                                                fit: BoxFit.contain,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: context.notchWidth * 0.04,
                                        ),
                                        child: RatingBarIndicator(
                                          rating: item.rating.rate.toDouble(),
                                          itemBuilder: (context, index) =>
                                              const Icon(
                                                Icons.star_rounded,
                                                color: Color(0xFFFFB300),
                                              ),
                                          itemCount: 5,
                                          itemSize: context.notchWidth * 0.035,
                                          direction: Axis.horizontal,
                                        ),
                                      ),
                                      SizedBox(
                                        height: context.notchHeight * 0.006,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: context.notchWidth * 0.04,
                                        ),
                                        child: Text(
                                          item.title,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontSize:
                                                context.notchWidth * 0.036,
                                            fontWeight: FontWeight.w600,
                                            color: value.isDark
                                                ? Colors.white
                                                : const Color(0xFF1A1A1A),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: context.notchHeight * 0.004,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: context.notchWidth * 0.04,
                                        ),
                                        child: Text(
                                          '\$${item.price}',
                                          style: TextStyle(
                                            fontSize:
                                                context.notchWidth * 0.038,
                                            fontWeight: FontWeight.w700,
                                            color: value.isDark
                                                ? Colors.white
                                                : const Color(0xFF1A1A1A),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: context.notchHeight * 0.012,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: context.notchWidth * 0.04,
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              '${item.rating.count} left',
                                              style: TextStyle(
                                                fontSize:
                                                    context.notchWidth * 0.028,
                                                color: const Color(0xFFC5221F),
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor:
                                                    AppColors.mainAppColor,
                                                elevation: 0,
                                                padding: EdgeInsets.symmetric(
                                                  horizontal:
                                                      context.notchWidth * 0.03,
                                                  vertical: 0,
                                                ),
                                                minimumSize: Size(
                                                  0,
                                                  context.notchHeight * 0.032,
                                                ),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
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
                                                item.buttonName == 'Add to Cart'
                                                    ? 'Add'
                                                    : 'Bag',
                                                style: TextStyle(
                                                  fontSize:
                                                      context.notchWidth *
                                                      0.028,
                                                  fontWeight: FontWeight.w700,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: context.notchHeight * 0.016,
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
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
