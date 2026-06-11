import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notch_r_shop_provider/constant/app_color.dart';
import 'package:notch_r_shop_provider/constant/responsiveness.dart';
import 'package:notch_r_shop_provider/provider/r_notch_provider.dart';

class BottomSheetSelectedQty extends StatelessWidget {
  final int productIndex;
  const BottomSheetSelectedQty({super.key, required this.productIndex});

  @override
  Widget build(BuildContext context) {
    final isDark = context.read<ProductProvider>().isDark;
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          backgroundColor: Colors.transparent,
          isScrollControlled: true,
          context: context,
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
                    color: isDark ? Colors.black54 : Colors.black12,
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
                          color: Colors.grey.shade400,
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                    ),
                  ),

                  Center(
                    child: Column(
                      children: [
                        Icon(
                          Icons.shopping_bag_outlined,
                          color: AppColors.mainAppColor,
                          size: context.notchWidth * 0.09,
                        ),

                        SizedBox(height: context.notchHeight * 0.008),

                        Text(
                          'Select Quantity',
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
                          'Choose your desired quantity',
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

                  Padding(
                    padding: EdgeInsets.only(
                      left: context.notchWidth * 0.05,
                      top: context.notchHeight * 0.015,
                    ),
                    child: Text(
                      'Available Quantity',
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
                      return SizedBox(
                        height: context.notchWidth * 0.18,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: 7,
                          separatorBuilder: (context, index) {
                            return SizedBox(width: context.notchWidth * 0.03);
                          },
                          itemBuilder: (context, index) {
                            final qty = value.cartItems[productIndex];

                            return Padding(
                              padding: EdgeInsets.only(
                                left: index == 0
                                    ? context.notchWidth * 0.04
                                    : 0,
                                right: index == 6
                                    ? context.notchWidth * 0.04
                                    : 0,
                              ),
                              child: GestureDetector(
                                onTap: () {
                                  value.selectQty(productIndex, index);
                                },
                                child: Container(
                                  height: context.notchWidth * 0.15,
                                  width: context.notchWidth * 0.15,

                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,

                                    color: qty.selectQtyIndex == index
                                        ? AppColors.mainAppColor
                                        : value.isDark
                                        ? const Color(0xFF2A2A2A)
                                        : Colors.white,

                                    border: Border.all(
                                      color: qty.selectQtyIndex == index
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
                                      '${index + 1}',
                                      style: TextStyle(
                                        fontSize: context.notchWidth * 0.040,
                                        fontWeight: FontWeight.w700,
                                        color: qty.selectQtyIndex == index
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
                            );
                          },
                        ),
                      );
                    },
                  ),
                  SizedBox(height: context.notchHeight * 0.020),

                  Consumer<ProductProvider>(
                    builder: (context, value, child) {
                      return GestureDetector(
                        onTap: () {
                          value.doneSelectQty(productIndex);
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
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: context.notchHeight * 0.038,
            padding: EdgeInsets.symmetric(
              horizontal: context.notchWidth * 0.010,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(context.notchWidth * 0.015),
              color: isDark ? const Color(0xFF2A2A2A) : const Color(0xFFF8F7FC),
              border: Border.all(
                color: const Color(0xFFD6CCFF),
                width: context.notchWidth * 0.003,
              ),
            ),
            child: Consumer<ProductProvider>(
              builder: (context, value, child) {
                return Row(
                  children: [
                    Center(
                      child: Text(
                        'Qty : ${value.cartItems[productIndex].qtySelect}',
                        style: GoogleFonts.darkerGrotesque(
                          fontWeight: FontWeight.bold,
                          fontSize: context.notchHeight * 0.018,
                          color: value.isDark ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                    Center(
                      child: Icon(
                        Icons.arrow_drop_down,
                        size: context.notchWidth * 0.05,
                        color: value.isDark ? Colors.white : Colors.black,
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
