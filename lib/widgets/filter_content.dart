import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:notch_r_shop_provider/provider/r_notch_provider.dart';

class FilterContent extends StatelessWidget {
  final IconData? icon;
  final String? title;

  const FilterContent({super.key, this.icon, this.title});

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductProvider>(
      builder: (context, value, child) {
        return Row(
          children: [
            Icon(icon, color: value.isDark ? Colors.white : Colors.black54),
            Text(
              '$title',
              style: TextStyle(
                color: value.isDark ? Colors.white : Colors.black54,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        );
      },
    );
  }
}
