import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notch_r_shop_provider/constant/app_color.dart';
import 'package:notch_r_shop_provider/screen/home_screen.dart';
import 'package:notch_r_shop_provider/constant/responsiveness.dart';
import 'package:notch_r_shop_provider/provider/r_notch_provider.dart';
import 'package:notch_r_shop_provider/screen/payment_success_screen.dart';
import 'package:notch_r_shop_provider/widgets/bottom_sheet_selected_qty.dart';
import 'package:notch_r_shop_provider/widgets/bottom_sheet_selected_size.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

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
          'Shopping Bag',
          style: GoogleFonts.pacifico(
            color: AppColors.appBackgroundColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),

      body: providerWatch.cartItems.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.shopping_cart_outlined,
                    size: context.notchWidth * 0.20,
                    color: providerWatch.isDark
                        ? Colors.white24
                        : Colors.grey.shade300,
                  ),

                  SizedBox(height: context.notchHeight * 0.02),

                  Text(
                    'Your cart is empty',

                    style: TextStyle(
                      fontSize: context.notchWidth * 0.045,
                      color: providerWatch.isDark
                          ? Colors.white
                          : Colors.grey.shade600,
                    ),
                  ),

                  SizedBox(height: context.notchHeight * 0.01),

                  Text(
                    'Add some premium products',
                    style: TextStyle(
                      fontSize: context.notchWidth * 0.035,
                      color: providerWatch.isDark
                          ? Colors.white70
                          : Colors.grey.shade500,
                    ),
                  ),

                  SizedBox(height: context.notchHeight * 0.03),

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

                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          context.notchWidth * 0.08,
                        ),
                      ),
                    ),

                    child: Text(
                      'Browse Products',
                      style: TextStyle(
                        color: Colors.white70,
                        fontWeight: FontWeight.bold,
                        fontSize: context.notchWidth * 0.035,
                      ),
                    ),
                  ),
                ],
              ),
            )
          : Consumer<ProductProvider>(
              builder: (context, value, child) {
                return ListView.builder(
                  physics: BouncingScrollPhysics(),
                  padding: EdgeInsets.only(bottom: context.notchHeight * 0.175),
                  itemCount: value.cartItems.length,

                  itemBuilder: (context, index) {
                    final item = value.cartItems[index];

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
                          Icons.delete_outline,
                          color: Colors.white,
                          size: context.notchWidth * 0.07,
                        ),
                      ),

                      onDismissed: (_) {
                        value.removeCart(index);
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: context.notchWidth * 0.04,
                          vertical: context.notchHeight * 0.01,
                        ),

                        child: Card(
                          elevation: providerWatch.isDark ? 1 : 3,
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
                                            color: providerWatch.isDark
                                                ? Colors.white
                                                : Colors.black,
                                            fontWeight: FontWeight.w600,
                                            fontSize:
                                                context.notchWidth * 0.037,
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
                                          height: context.notchHeight * 0.01,
                                        ),

                                        Container(
                                          decoration: BoxDecoration(
                                            color: providerWatch.isDark
                                                ? const Color(0xFF2A2A2A)
                                                : Colors.grey.shade50,
                                            borderRadius: BorderRadius.circular(
                                              context.notchWidth * 0.08,
                                            ),
                                          ),

                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              BottomSheetSelectedSize(
                                                product: value.cartItems[index],
                                                index: index,
                                              ),
                                              SizedBox(
                                                width:
                                                    context.notchWidth * 0.005,
                                              ),
                                              BottomSheetSelectedQty(
                                                productIndex: index,
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: context.notchHeight * 0.010,
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

                                SizedBox(
                                  width: context.notchWidth * 0.08,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                          bottom: context.notchHeight * 0.13,
                                        ),
                                        child: InkWell(
                                          onTap: () {
                                            value.removeCart(index);
                                            // item.quantity = 1;
                                          },
                                          child: Icon(
                                            Icons.delete,
                                            color: Colors.red,
                                            size: context.notchWidth * 0.060,
                                          ),
                                        ),
                                      ),
                                    ],
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
      bottomSheet: Consumer<ProductProvider>(
        builder: (context, value, child) {
          if (value.cartItems.isNotEmpty) {
            return Container(
              decoration: BoxDecoration(
                color: value.isDark ? const Color(0xFF1E1E1E) : Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(context.notchWidth * 0.07),
                  topRight: Radius.circular(context.notchWidth * 0.07),
                ),
                boxShadow: [
                  BoxShadow(
                    color: value.isDark
                        ? Colors.black54
                        : Colors.black.withOpacity(0.08),
                    blurRadius: context.notchWidth * 0.06,
                    spreadRadius: 2,
                    offset: Offset(0, -context.notchHeight * 0.004),
                  ),
                ],
              ),
              child: SafeArea(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: context.notchWidth * 0.05,
                    vertical: context.notchHeight * 0.018,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        height: context.notchHeight * 0.005,
                        width: context.notchWidth * 0.15,
                        decoration: BoxDecoration(
                          color: value.isDark
                              ? Colors.white24
                              : Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(
                            context.notchWidth * 0.02,
                          ),
                        ),
                      ),

                      SizedBox(height: context.notchHeight * 0.02),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Total Amount',
                            style: TextStyle(
                              fontSize: context.notchWidth * 0.042,
                              color: value.isDark
                                  ? Colors.white70
                                  : Colors.grey.shade600,
                              fontWeight: FontWeight.w500,
                            ),
                          ),

                          Text(
                            '\$${value.totalAmount().toStringAsFixed(2)}',
                            style: TextStyle(
                              fontSize: context.notchWidth * 0.065,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF6C63FF),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: context.notchHeight * 0.02),

                      SizedBox(
                        width: double.infinity,
                        height: context.notchHeight * 0.065,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            elevation: 8,
                            shadowColor: const Color(
                              0xFF6C63FF,
                            ).withOpacity(0.35),

                            backgroundColor: const Color(0xFF6C63FF),

                            foregroundColor: Colors.white,

                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                context.notchWidth * 0.04,
                              ),
                            ),
                          ),

                          onPressed: () {
                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                pageBuilder:
                                    (context, animation, secondaryAnimation) =>
                                        PaymentSuccessScreen(),

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

                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.shopping_bag_outlined,
                                size: context.notchWidth * 0.05,
                              ),

                              SizedBox(width: context.notchWidth * 0.02),

                              Text(
                                'Proceed to Checkout',
                                style: TextStyle(
                                  fontSize: context.notchWidth * 0.04,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 0.4,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
          return SizedBox.shrink();
        },
      ),
    );
  }
}
