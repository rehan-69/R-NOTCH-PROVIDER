import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:notch_r_shop_provider/widgets/filter_content.dart';
import 'package:notch_r_shop_provider/constant/responsiveness.dart';
import 'package:notch_r_shop_provider/widgets/list_tile_custom.dart';
import 'package:notch_r_shop_provider/provider/r_notch_provider.dart';

class ShowModelBottomSheet extends StatelessWidget {
  const ShowModelBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          context: context,
          backgroundColor: Colors.transparent,
          builder: (context) {
            return Consumer<ProductProvider>(
              builder: (context, value, child) {
                return Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: value.isDark
                        ? const Color(0xFF1E1E1E)
                        : Colors.white,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(context.notchWidth * 0.065),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: value.isDark
                            ? Colors.black54
                            : Colors.black.withOpacity(0.08),
                        blurRadius: 20,
                        spreadRadius: 2,
                        offset: const Offset(0, -4),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(height: context.notchHeight * 0.015),

                      Container(
                        width: context.notchWidth * 0.18,
                        height: context.notchHeight * 0.006,
                        decoration: BoxDecoration(
                          color: value.isDark
                              ? Colors.white24
                              : Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(
                            context.notchWidth * 0.05,
                          ),
                        ),
                      ),

                      SizedBox(height: context.notchHeight * 0.025),

                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: context.notchWidth * 0.06,
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(
                                context.notchWidth * 0.025,
                              ),
                              decoration: BoxDecoration(
                                color: value.isDark
                                    ? const Color(0xFF2A2A2A)
                                    : Colors.grey.shade100,
                                borderRadius: BorderRadius.circular(
                                  context.notchWidth * 0.03,
                                ),
                              ),
                              child: Icon(
                                Icons.sort_rounded,
                                size: context.notchWidth * 0.06,
                                color: value.isDark
                                    ? Colors.white
                                    : Colors.black87,
                              ),
                            ),

                            SizedBox(width: context.notchWidth * 0.035),

                            Text(
                              'SORT BY',
                              style: TextStyle(
                                fontSize: context.notchWidth * 0.045,
                                fontWeight: FontWeight.w900,
                                letterSpacing: 1.2,
                                color: value.isDark
                                    ? Colors.white
                                    : Colors.black87,
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: context.notchHeight * 0.02),

                      Divider(
                        height: 1,
                        thickness: 1,
                        color: value.isDark
                            ? Colors.white24
                            : Colors.grey.shade200,
                      ),

                      SizedBox(height: context.notchHeight * 0.01),

                      ListTileCustom(
                        onTap: () {
                          value.priceHighToLow();
                          value.isFiltersData = 'PRICE: HIGH TO LOW';
                          value.filterSave();
                          Navigator.pop(context);
                        },
                        icon: Icons.trending_down,
                        color: Colors.green,
                        title: 'PRICE: HIGH TO LOW',
                      ),

                      ListTileCustom(
                        onTap: () {
                          value.priceLowToHigh();
                          value.isFiltersData = 'PRICE: LOW TO HIGH';
                          value.filterSave();
                          Navigator.pop(context);
                        },
                        icon: Icons.trending_up,
                        color: Colors.green,
                        title: 'PRICE: LOW TO HIGH',
                      ),

                      ListTileCustom(
                        onTap: () {
                          value.bestRating();
                          value.isFiltersData = 'RATING: BEST RATING';
                          value.filterSave();
                          Navigator.pop(context);
                        },
                        icon: Icons.workspace_premium,
                        color: Colors.amber,
                        title: 'RATING: BEST RATING',
                      ),

                      ListTileCustom(
                        onTap: () {
                          value.resetFilter();
                          value.isFiltersData = 'FILTER: RESET FILTER';
                          value.filterSave();
                          Navigator.pop(context);
                        },
                        icon: Icons.refresh,
                        color: Colors.amber,
                        title: 'FILTER: RESET FILTER',
                      ),

                      SizedBox(height: context.notchHeight * 0.02),
                    ],
                  ),
                );
              },
            );
          },
        );
      },
      child: Container(
        padding: EdgeInsets.all(context.notchHeight * 0.015),
        height: context.notchHeight * 0.06,
        color: context.read<ProductProvider>().isDark
            ? const Color(0xFF1E1E1E)
            : Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FilterContent(icon: Icons.filter_list, title: 'Filters'),
            Consumer<ProductProvider>(
              builder: (context, value, child) {
                return FilterContent(
                  icon: Icons.swap_vert,
                  title: value.isFiltersData,
                );
              },
            ),
            FilterContent(icon: Icons.view_list, title: ''),
          ],
        ),
      ),
    );
  }
}
