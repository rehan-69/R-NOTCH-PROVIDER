import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notch_r_shop_provider/constant/app_color.dart';
import 'package:notch_r_shop_provider/model/product_model.dart';
import 'package:notch_r_shop_provider/constant/responsiveness.dart';
import 'package:notch_r_shop_provider/provider/r_notch_provider.dart';

class BottomSheetSelectedSize extends StatelessWidget {
  final Product product;
  final int index;
  const BottomSheetSelectedSize({
    super.key,
    required this.product,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          context: context,
          backgroundColor: Colors.transparent,
          isScrollControlled: true,
          builder: (context) {
            return Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: context.read<ProductProvider>().isDark
                    ? const Color(0xFF1E1E1E)
                    : Colors.white,

                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(context.notchWidth * 0.08),
                  topRight: Radius.circular(context.notchWidth * 0.08),
                ),

                boxShadow: [
                  BoxShadow(
                    color: context.read<ProductProvider>().isDark
                        ? Colors.black54
                        : Colors.black12,
                    blurRadius: 20,
                    offset: Offset(0, -5),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: context.notchHeight * 0.02,
                      ),

                      child: Container(
                        width: context.notchWidth * 0.15,
                        height: context.notchHeight * 0.006,
                        decoration: BoxDecoration(
                          color: context.read<ProductProvider>().isDark
                              ? Colors.white24
                              : Colors.grey.shade400,
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                    ),
                  ),

                  Center(
                    child: Column(
                      children: [
                        Icon(
                          Icons.checkroom,
                          color: AppColors.mainAppColor,
                          size: context.notchWidth * 0.09,
                        ),

                        SizedBox(height: context.notchHeight * 0.008),

                        Text(
                          'Select Size',
                          style: TextStyle(
                            fontSize: context.notchWidth * 0.055,
                            fontWeight: FontWeight.w800,
                            color: context.read<ProductProvider>().isDark
                                ? Colors.white
                                : Colors.black87,
                          ),
                        ),

                        SizedBox(height: context.notchHeight * 0.004),
                        Text(
                          'Choose your perfect fit',
                          style: TextStyle(
                            color: context.read<ProductProvider>().isDark
                                ? Colors.white70
                                : Colors.grey.shade600,
                            fontSize: context.notchWidth * 0.034,
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: context.notchHeight * 0.018),

                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: context.notchWidth * 0.04,
                    ),

                    child: Container(
                      width: double.infinity,

                      padding: EdgeInsets.all(context.notchWidth * 0.04),

                      decoration: BoxDecoration(
                        color: context.read<ProductProvider>().isDark
                            ? const Color(0xFF2A2A2A)
                            : Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: context.read<ProductProvider>().isDark
                              ? Colors.white24
                              : Colors.grey.shade200,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: context.read<ProductProvider>().isDark
                                ? Colors.black54
                                : Colors.black.withOpacity(0.05),
                            blurRadius: 12,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),

                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: [
                          Text(
                            'Price : \$${product.price}',
                            style: TextStyle(
                              color: Colors.green.shade700,
                              fontWeight: FontWeight.bold,
                              fontSize: context.notchWidth * 0.05,
                            ),
                          ),

                          SizedBox(height: context.notchHeight * 0.010),

                          Row(
                            children: [
                              Icon(
                                Icons.storefront,
                                color: context.read<ProductProvider>().isDark
                                    ? Colors.white70
                                    : Colors.grey,
                                size: context.notchWidth * 0.04,
                              ),

                              SizedBox(width: 6),

                              Expanded(
                                child: Text(
                                  'Sold & Fulfilled by R Notch Fashion Hub',
                                  style: TextStyle(
                                    color:
                                        context.read<ProductProvider>().isDark
                                        ? Colors.white70
                                        : Colors.grey.shade700,
                                    fontWeight: FontWeight.w500,
                                    fontSize: context.notchWidth * 0.038,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: context.notchHeight * 0.020),
                  Padding(
                    padding: EdgeInsets.only(
                      left: context.notchWidth * 0.05,
                      top: context.notchHeight * 0,
                    ),
                    child: Text(
                      'Available Sizes',
                      style: TextStyle(
                        fontSize: context.notchWidth * 0.042,
                        fontWeight: FontWeight.bold,
                        color: context.read<ProductProvider>().isDark
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                  ),

                  SizedBox(height: context.notchHeight * 0.015),

                  Consumer<ProductProvider>(
                    builder: (context, value, child) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,

                        children: [
                          GestureDetector(
                            onTap: () {
                              value.sizeSelect(index, 'XS');
                            },
                            child: Container(
                              height: context.notchWidth * 0.15,
                              width: context.notchWidth * 0.15,

                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color:
                                    value.cartItems[index].selectedSize == 'XS'
                                    ? AppColors.mainAppColor
                                    : value.isDark
                                    ? const Color(0xFF2A2A2A)
                                    : Colors.white,
                                border: Border.all(
                                  color:
                                      value.cartItems[index].selectedSize ==
                                          'XS'
                                      ? AppColors.mainAppColor
                                      : Colors.grey.shade400,
                                  width: 1.5,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: value.isDark
                                        ? Colors.black54
                                        : Colors.black12,
                                    blurRadius: 6,
                                    offset: Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Center(
                                child: Text(
                                  'XS',
                                  style: TextStyle(
                                    fontSize: context.notchWidth * 0.040,
                                    fontWeight: FontWeight.w700,
                                    color:
                                        value.cartItems[index].selectedSize ==
                                            'XS'
                                        ? Colors.white
                                        : value.isDark
                                        ? Colors.white
                                        : Colors.black87,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: context.notchHeight * 0.003),

                          GestureDetector(
                            onTap: () {
                              value.sizeSelect(index, 'S');
                            },
                            child: Container(
                              height: context.notchWidth * 0.15,
                              width: context.notchWidth * 0.15,

                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color:
                                    value.cartItems[index].selectedSize == 'S'
                                    ? AppColors.mainAppColor
                                    : value.isDark
                                    ? const Color(0xFF2A2A2A)
                                    : Colors.white,
                                border: Border.all(
                                  color:
                                      value.cartItems[index].selectedSize == 'S'
                                      ? AppColors.mainAppColor
                                      : Colors.grey.shade400,
                                  width: 1.5,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: value.isDark
                                        ? Colors.black54
                                        : Colors.black12,
                                    blurRadius: 6,
                                    offset: Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Center(
                                child: Text(
                                  'S',
                                  style: TextStyle(
                                    fontSize: context.notchWidth * 0.040,
                                    fontWeight: FontWeight.w700,
                                    color:
                                        value.cartItems[index].selectedSize ==
                                            'S'
                                        ? Colors.white
                                        : value.isDark
                                        ? Colors.white
                                        : Colors.black87,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                              ),
                            ),
                          ),

                          SizedBox(width: context.notchHeight * 0.003),

                          GestureDetector(
                            onTap: () {
                              value.sizeSelect(index, 'M');
                            },
                            child: Container(
                              height: context.notchWidth * 0.15,
                              width: context.notchWidth * 0.15,

                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color:
                                    value.cartItems[index].selectedSize == 'M'
                                    ? AppColors.mainAppColor
                                    : value.isDark
                                    ? const Color(0xFF2A2A2A)
                                    : Colors.white,
                                border: Border.all(
                                  color:
                                      value.cartItems[index].selectedSize == 'M'
                                      ? AppColors.mainAppColor
                                      : Colors.grey.shade400,
                                  width: 1.5,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: value.isDark
                                        ? Colors.black54
                                        : Colors.black12,
                                    blurRadius: 6,
                                    offset: Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Center(
                                child: Text(
                                  'M',
                                  style: TextStyle(
                                    fontSize: context.notchWidth * 0.040,
                                    fontWeight: FontWeight.w700,
                                    color:
                                        value.cartItems[index].selectedSize ==
                                            'M'
                                        ? Colors.white
                                        : value.isDark
                                        ? Colors.white
                                        : Colors.black87,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                              ),
                            ),
                          ),

                          SizedBox(width: context.notchHeight * 0.003),

                          GestureDetector(
                            onTap: () {
                              value.sizeSelect(index, 'L');
                            },
                            child: Container(
                              height: context.notchWidth * 0.15,
                              width: context.notchWidth * 0.15,

                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color:
                                    value.cartItems[index].selectedSize == 'L'
                                    ? AppColors.mainAppColor
                                    : value.isDark
                                    ? const Color(0xFF2A2A2A)
                                    : Colors.white,
                                border: Border.all(
                                  color:
                                      value.cartItems[index].selectedSize == 'L'
                                      ? AppColors.mainAppColor
                                      : Colors.grey.shade400,
                                  width: 1.5,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: value.isDark
                                        ? Colors.black54
                                        : Colors.black12,
                                    blurRadius: 6,
                                    offset: Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Center(
                                child: Text(
                                  'L',
                                  style: TextStyle(
                                    fontSize: context.notchWidth * 0.040,
                                    fontWeight: FontWeight.w700,
                                    color:
                                        value.cartItems[index].selectedSize ==
                                            'L'
                                        ? Colors.white
                                        : value.isDark
                                        ? Colors.white
                                        : Colors.black87,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                              ),
                            ),
                          ),

                          SizedBox(width: context.notchHeight * 0.003),

                          GestureDetector(
                            onTap: () {
                              value.sizeSelect(index, 'XL');
                            },
                            child: Container(
                              height: context.notchWidth * 0.15,
                              width: context.notchWidth * 0.15,

                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color:
                                    value.cartItems[index].selectedSize == 'XL'
                                    ? AppColors.mainAppColor
                                    : value.isDark
                                    ? const Color(0xFF2A2A2A)
                                    : Colors.white,
                                border: Border.all(
                                  color:
                                      value.cartItems[index].selectedSize ==
                                          'XL'
                                      ? AppColors.mainAppColor
                                      : Colors.grey.shade400,
                                  width: 1.5,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: value.isDark
                                        ? Colors.black54
                                        : Colors.black12,
                                    blurRadius: 6,
                                    offset: Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Center(
                                child: Text(
                                  'XL',
                                  style: TextStyle(
                                    fontSize: context.notchWidth * 0.040,
                                    fontWeight: FontWeight.w700,
                                    color:
                                        value.cartItems[index].selectedSize ==
                                            'XL'
                                        ? Colors.white
                                        : value.isDark
                                        ? Colors.white
                                        : Colors.black87,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                              ),
                            ),
                          ),

                          SizedBox(width: context.notchHeight * 0.003),

                          GestureDetector(
                            onTap: () {
                              value.sizeSelect(index, 'XXL');
                            },
                            child: Container(
                              height: context.notchWidth * 0.15,
                              width: context.notchWidth * 0.15,

                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color:
                                    value.cartItems[index].selectedSize == 'XXL'
                                    ? AppColors.mainAppColor
                                    : value.isDark
                                    ? const Color(0xFF2A2A2A)
                                    : Colors.white,
                                border: Border.all(
                                  color:
                                      value.cartItems[index].selectedSize ==
                                          'XXL'
                                      ? AppColors.mainAppColor
                                      : Colors.grey.shade400,
                                  width: 1.5,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: value.isDark
                                        ? Colors.black54
                                        : Colors.black12,
                                    blurRadius: 6,
                                    offset: Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Center(
                                child: Text(
                                  'XXL',
                                  style: TextStyle(
                                    fontSize: context.notchWidth * 0.040,
                                    fontWeight: FontWeight.w700,
                                    color:
                                        value.cartItems[index].selectedSize ==
                                            'XXL'
                                        ? Colors.white
                                        : value.isDark
                                        ? Colors.white
                                        : Colors.black87,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                  SizedBox(height: context.notchHeight * 0.025),
                  Consumer<ProductProvider>(
                    builder: (context, value, child) {
                      return GestureDetector(
                        onTap: () {
                          value.doneSelectSize(index);
                          Navigator.pop(context);
                        },
                        child: Container(
                          margin: EdgeInsets.all(context.notchWidth * 0.04),
                          height: context.notchHeight * 0.07,
                          decoration: BoxDecoration(
                            color: AppColors.mainAppColor,
                            borderRadius: BorderRadius.circular(18),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.mainAppColor.withOpacity(0.35),
                                blurRadius: 10,
                                offset: Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.check, color: Colors.white),

                              SizedBox(width: 8),

                              Text(
                                'Done',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: context.notchWidth * 0.045,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            );
          },
        );
      },
      child: Container(
        height: context.notchHeight * 0.038,
        padding: EdgeInsets.symmetric(horizontal: context.notchWidth * 0.010),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(context.notchWidth * 0.015),
          color: context.read<ProductProvider>().isDark
              ? const Color(0xFF2A2A2A)
              : const Color(0xFFF8F7FC),
          border: Border.all(
            color: const Color(0xFFD6CCFF),
            width: context.notchWidth * 0.003,
          ),
        ),
        child: Row(
          children: [
            Center(
              child: Text(
                'Size: ${product.size}',
                style: GoogleFonts.darkerGrotesque(
                  fontWeight: FontWeight.bold,
                  fontSize: context.notchHeight * 0.018,
                  color: context.read<ProductProvider>().isDark
                      ? Colors.white
                      : Colors.black,
                ),
              ),
            ),
            Center(
              child: Icon(
                Icons.arrow_drop_down,
                size: context.notchWidth * 0.05,
                color: context.read<ProductProvider>().isDark
                    ? Colors.white
                    : Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
