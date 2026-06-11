import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:notch_r_shop_provider/constant/responsiveness.dart';
import 'package:notch_r_shop_provider/provider/r_notch_provider.dart';

class PaymentSuccessScreen extends StatelessWidget {
  const PaymentSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductProvider>(
      builder: (context, value, child) {
        return Scaffold(
          backgroundColor: value.isDark ? Colors.black : Colors.white,
          body: Consumer<ProductProvider>(
            builder: (context, value, child) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.check_circle,
                      color: Colors.green,
                      size: context.notchWidth * 0.30,
                    ),

                    SizedBox(height: context.notchHeight * 0.025),

                    Text(
                      'Payment Successful',
                      style: TextStyle(
                        fontSize: context.notchWidth * 0.065,
                        fontWeight: FontWeight.bold,
                        color: value.isDark ? Colors.white : Colors.black,
                      ),
                    ),

                    SizedBox(height: context.notchHeight * 0.01),

                    Text(
                      'Your order has been placed',
                      style: TextStyle(
                        fontSize: context.notchWidth * 0.045,
                        color: value.isDark ? Colors.white70 : Colors.black87,
                      ),
                    ),

                    SizedBox(height: context.notchHeight * 0.04),

                    InkWell(
                      borderRadius: BorderRadius.circular(
                        context.notchWidth * 0.03,
                      ),
                      onTap: () {
                        value.clearCart();
                        Navigator.pop(context);
                      },
                      child: Container(
                        width: context.notchWidth * 0.55,
                        height: context.notchHeight * 0.06,
                        decoration: BoxDecoration(
                          color: const Color(0xFF6C63FF),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(15),
                            onTap: () {
                              value.clearCart();
                              Navigator.pop(context);
                            },
                            child: Center(
                              child: Text(
                                'Shop More',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: context.notchWidth * 0.04,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
