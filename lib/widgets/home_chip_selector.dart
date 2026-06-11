import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:notch_r_shop_provider/constant/app_color.dart';
import 'package:notch_r_shop_provider/constant/responsiveness.dart';
import 'package:notch_r_shop_provider/provider/r_notch_provider.dart';

class HomeChipSelector extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final String select;

  const HomeChipSelector({
    super.key,
    required this.title,
    required this.onTap,
    required this.select,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductProvider>(
      builder: (context, value, child) {
        return GestureDetector(
          onTap: onTap,
          child: Container(
            margin: EdgeInsets.symmetric(
              horizontal: context.notchWidth * 0.02,
            ),
            padding: EdgeInsets.symmetric(
              horizontal: context.notchWidth * 0.05,
              vertical: context.notchHeight * 0.010,
            ),
            decoration: BoxDecoration(
              border: Border.all(
                color: AppColors.mainAppColor,
              ),
              color: select == 'select'
                  ? AppColors.mainAppColor
                  : value.isDark
                      ? const Color(0xFF2A2A2A)
                      : Colors.white,
              borderRadius: BorderRadius.circular(
                context.notchHeight * 0.01,
              ),
            ),
            child: Center(
              child: Text(
                title,
                style: TextStyle(
                  color: select == 'select'
                      ? Colors.white
                      : value.isDark
                          ? Colors.white
                          : AppColors.mainAppColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}