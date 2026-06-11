import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:notch_r_shop_provider/constant/app_color.dart';
import 'package:notch_r_shop_provider/constant/responsiveness.dart';
import 'package:notch_r_shop_provider/provider/r_notch_provider.dart';

class TextFieldCustom extends StatelessWidget {
  const TextFieldCustom({super.key});

  @override
  Widget build(BuildContext context) {
    final providerRead = context.read<ProductProvider>();

    return Consumer<ProductProvider>(
      builder: (context, value, child) {
        return Padding(
          padding: EdgeInsets.all(context.notchWidth * 0.03),

          child: TextField(
            controller: providerRead.searchController,
            onChanged: (value) {
              providerRead.isSearching = value;
              providerRead.onSearchChanged();
              providerRead.searching();
              providerRead.textFieldSearchingSave();
            },

            style: TextStyle(color: value.isDark ? Colors.white : Colors.black),

            decoration: InputDecoration(
              filled: true,
              fillColor: value.isDark ? const Color(0xFF1E1E1E) : Colors.white,

              hintText: 'Search...',
              hintStyle: TextStyle(
                color: value.isDark ? Colors.white70 : Colors.black54,
                fontSize: context.notchWidth * 0.045,
              ),

              prefixIcon: Icon(
                Icons.search,
                color: value.isDark ? Colors.white70 : Colors.black54,
              ),

              suffixIcon: value.searchController.text.isNotEmpty
                  ? GestureDetector(
                      onTap: () {
                        providerRead.isSerachIconShow();
                      },
                      child: Icon(
                        Icons.close,
                        size: context.notchWidth * 0.045,
                        color: value.isDark ? Colors.white70 : Colors.black54,
                      ),
                    )
                  : const SizedBox.shrink(),

              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(context.notchWidth * 0.02),
                borderSide: BorderSide(color: AppColors.mainAppColor),
              ),

              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(context.notchWidth * 0.02),
                borderSide: BorderSide(color: AppColors.mainAppColor),
              ),

              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(context.notchWidth * 0.02),
                borderSide: BorderSide(
                  color: AppColors.mainAppColor,
                  width: 1.5,
                ),
              ),

              contentPadding: EdgeInsets.symmetric(
                vertical: context.notchHeight * 0.015,
                horizontal: context.notchWidth * 0.04,
              ),
            ),
          ),
        );
      },
    );
  }
}
