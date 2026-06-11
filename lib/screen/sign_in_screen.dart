import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:notch_r_shop_provider/screen/home_screen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:notch_r_shop_provider/constant/responsiveness.dart';
import 'package:notch_r_shop_provider/provider/r_notch_provider.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({super.key});
  final RegExp emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+$');
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductProvider>(
      builder: (context, value, child) {
        return GestureDetector(
          onTap: (){
              FocusScope.of(context).unfocus();
          },
          child: Scaffold(
            backgroundColor: value.isDark
                ? const Color(0xFF121212)
                : Colors.white,
            body: SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: context.notchWidth * 0.06,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: context.notchHeight * 0.06),
                      Text(
                        'Welcome Back',
                        style: TextStyle(
                          fontSize: context.notchWidth * 0.08,
                          fontWeight: FontWeight.bold,
                          color: value.isDark ? Colors.white : Colors.black,
                          letterSpacing: 0.5,
                        ),
                      ),
                      SizedBox(height: context.notchHeight * 0.015),
                      Text(
                        'Sign in with your email and password\nor continue with social media',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: context.notchWidth * 0.038,
                          color: value.isDark ? Colors.white70 : Colors.grey,
                          height: 1.5,
                        ),
                      ),
                      SizedBox(height: context.notchHeight * 0.06),
                      Form(
                        key: formKey,
                        child: Column(
                          children: [
                            TextFormField(
                              style: TextStyle(
                                color: value.isDark ? Colors.white : Colors.black,
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your email';
                                }
                                if (!emailRegex.hasMatch(value)) {
                                  return 'Please enter a valid email';
                                }
                                return null;
                              },
                              onChanged: (val) {
                                value.emailStore = val;
                                value.emailSave();
                              },
                              controller: value.emailController,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                hintText: 'Email',
                                hintStyle: TextStyle(
                                  color: value.isDark
                                      ? Colors.white70
                                      : Colors.grey,
                                ),
                                prefixIcon: Icon(
                                  Icons.email_outlined,
                                  color: const Color(0xFF6C63FF),
                                  size: context.notchWidth * 0.06,
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                  vertical: context.notchHeight * 0.022,
                                  horizontal: context.notchWidth * 0.04,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide: const BorderSide(
                                    color: Color(0xFFE0E0E0),
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide: const BorderSide(
                                    color: Color(0xFFE0E0E0),
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide: const BorderSide(
                                    color: Color(0xFF6C63FF),
                                    width: 2,
                                  ),
                                ),
                                filled: true,
                                fillColor: value.isDark
                                    ? const Color(0xFF2A2A2A)
                                    : const Color(0xFFF9F9F9),
                              ),
                            ),
          
                            SizedBox(height: context.notchHeight * 0.024),
          
                            TextFormField(
                              style: TextStyle(
                                color: value.isDark ? Colors.white : Colors.black,
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your password';
                                }
                                if (value.length < 6) {
                                  return 'Please enter a valid password';
                                }
                                return null;
                              },
                              controller: value.passwordController,
                              obscureText: value.isPasswordVisible,
                              decoration: InputDecoration(
                                hintText: 'Password',
                                hintStyle: TextStyle(
                                  color: value.isDark
                                      ? Colors.white70
                                      : Colors.grey,
                                ),
                                prefixIcon: Icon(
                                  Icons.lock_outline_rounded,
                                  color: const Color(0xFF6C63FF),
                                  size: context.notchWidth * 0.06,
                                ),
                                suffixIcon: GestureDetector(
                                  onTap: () {
                                    value.passwordHideShow();
                                  },
                                  child: Icon(
                                    value.isPasswordVisible
                                        ? Icons.visibility_off_outlined
                                        : Icons.visibility_outlined,
                                    color: value.isDark
                                        ? Colors.white70
                                        : Colors.grey,
                                    size: context.notchWidth * 0.06,
                                  ),
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                  vertical: context.notchHeight * 0.022,
                                  horizontal: context.notchWidth * 0.04,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide: const BorderSide(
                                    color: Color(0xFFE0E0E0),
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide: const BorderSide(
                                    color: Color(0xFFE0E0E0),
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide: const BorderSide(
                                    color: Color(0xFF6C63FF),
                                    width: 2,
                                  ),
                                ),
                                filled: true,
                                fillColor: value.isDark
                                    ? const Color(0xFF2A2A2A)
                                    : const Color(0xFFF9F9F9),
                              ),
                            ),
                          ],
                        ),
                      ),
          
                      SizedBox(height: context.notchHeight * 0.02),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                height: context.notchHeight * 0.03,
                                width: context.notchWidth * 0.06,
                                child: Checkbox(
                                  value: value.rememberMe,
                                  onChanged: (val) {
                                    value.rememberMe = val!;
                                    value.notifyListeners();
                                  },
                                  activeColor: const Color(0xFF6C63FF),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                ),
                              ),
                              SizedBox(width: context.notchWidth * 0.02),
                              Text(
                                'Remember me',
                                style: TextStyle(
                                  color: value.isDark
                                      ? Colors.white
                                      : Colors.black87,
                                  fontSize: context.notchWidth * 0.036,
                                ),
                              ),
                            ],
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: Text(
                              'Forgot Password?',
                              style: TextStyle(
                                color: const Color(0xFF6C63FF),
                                fontWeight: FontWeight.w600,
                                fontSize: context.notchWidth * 0.036,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: context.notchHeight * 0.05),
                      Container(
                        width: double.infinity,
                        height: context.notchHeight * 0.068,
                        decoration: BoxDecoration(
                          color: const Color(0xFF6C63FF),
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF6C63FF).withOpacity(0.3),
                              blurRadius: 12,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: ElevatedButton(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              value.isLogin = true;
                              value.loginSave();
                              Navigator.pushReplacement(
                                context,
                                PageRouteBuilder(
                                  pageBuilder:
                                      (context, animation, secondaryAnimation) =>
                                          HomeScreen(),
          
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
                              value.emailController.clear();
                              value.passwordController.clear();
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          child: Text(
                            'Continue',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: context.notchWidth * 0.04,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: context.notchHeight * 0.06),
                      Row(
                        children: [
                          Expanded(
                            child: Divider(
                              color: value.isDark
                                  ? Colors.white24
                                  : const Color(0xFFE2E8F0),
                              thickness: 1,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: context.notchWidth * 0.04,
                            ),
                            child: Text(
                              'Or continue with',
                              style: TextStyle(
                                color: value.isDark
                                    ? Colors.white70
                                    : Colors.grey,
                                fontSize: context.notchWidth * 0.036,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Divider(
                              color: value.isDark
                                  ? Colors.white24
                                  : const Color(0xFFE2E8F0),
                              thickness: 1,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: context.notchHeight * 0.035),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: EdgeInsets.all(context.notchWidth * 0.04),
                            decoration: BoxDecoration(
                              color: value.isDark
                                  ? const Color(0xFF2A2A2A)
                                  : Colors.white,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: value.isDark
                                      ? Colors.black54
                                      : Colors.black.withOpacity(0.05),
                                  blurRadius: 10,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Image.asset(
                              'assets/google_logo.png',
                              height: context.notchHeight * 0.04,
                              width: context.notchWidth * 0.08,
                            ),
                          ),
                          SizedBox(width: context.notchWidth * 0.06),
                          Container(
                            padding: EdgeInsets.all(context.notchWidth * 0.04),
                            decoration: BoxDecoration(
                              color: value.isDark
                                  ? const Color(0xFF2A2A2A)
                                  : Colors.white,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: value.isDark
                                      ? Colors.black54
                                      : Colors.black.withOpacity(0.05),
                                  blurRadius: 10,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: FaIcon(
                              FontAwesomeIcons.facebook,
                              size: context.notchWidth * 0.085,
                              color: Colors.blue,
                            ),
                          ),
                          SizedBox(width: context.notchWidth * 0.06),
                          Container(
                            padding: EdgeInsets.all(context.notchWidth * 0.04),
                            decoration: BoxDecoration(
                              color: value.isDark
                                  ? const Color(0xFF2A2A2A)
                                  : Colors.white,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: value.isDark
                                      ? Colors.black54
                                      : Colors.black.withOpacity(0.05),
                                  blurRadius: 10,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: FaIcon(
                              FontAwesomeIcons.twitter,
                              size: context.notchWidth * 0.08,
                              color: Colors.lightBlue,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: context.notchHeight * 0.05),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Don't have an account? ",
                            style: TextStyle(
                              color: value.isDark ? Colors.white70 : Colors.grey,
                              fontSize: context.notchWidth * 0.038,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: Text(
                              'Sign Up',
                              style: TextStyle(
                                color: const Color(0xFF6C63FF),
                                fontWeight: FontWeight.bold,
                                fontSize: context.notchWidth * 0.038,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: context.notchHeight * 0.03),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
