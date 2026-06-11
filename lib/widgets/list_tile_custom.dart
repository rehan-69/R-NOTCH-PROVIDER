import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:notch_r_shop_provider/constant/responsiveness.dart';
import 'package:notch_r_shop_provider/provider/r_notch_provider.dart';

class ListTileCustom extends StatelessWidget {
  final VoidCallback? onTap;
  final IconData? icon;
  final Color? color;
  final String? title;

  const ListTileCustom({
    super.key,
    this.onTap,
    this.icon,
    this.color,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductProvider>(
      builder: (context, value, child) {
        return ListTile(
          onTap: onTap,
          leading: Icon(icon, color: color),
          title: Text(
            '$title',
            style: TextStyle(
              color: value.isDark
                  ? Colors.white
                  : Colors.black,
              fontSize: context.notchWidth * 0.043,
            ),
          ),
        );
      },
    );
  }
}