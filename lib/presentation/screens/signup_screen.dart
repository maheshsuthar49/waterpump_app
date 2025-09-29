import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:water_pump/presentation/screens/dashboard_screen.dart';
import 'package:water_pump/presentation/screens/signin_screen.dart';

import '../../controller/auth_controller.dart';

class SignUpScreen extends StatelessWidget {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final authController = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Column(
              children: [
                Container(
                  height: screenHeight * 0.5,
                  width: double.infinity,
                  child: Image.network(
                    "https://images.pexels.com/photos/1658967/pexels-photo-1658967.jpeg",
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  height: screenHeight * 0.5,
                  width: double.infinity,
                  decoration: const BoxDecoration(color: Colors.white),
                  padding: EdgeInsets.all(screenWidth * 0.08),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: screenHeight * 0.05),
                      const Text(
                        "EMAIL / REGISTERED MOBILE NUMBER",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextFormField(
                        controller: emailController,
                        decoration: const InputDecoration(
                          border: UnderlineInputBorder(),
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      const Text(
                        "PASSWORD",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextFormField(
                        controller: passwordController,
                        obscureText: true,
                        decoration: const InputDecoration(
                          border: UnderlineInputBorder(),
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.05),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            authController.signUp(emailController.text, passwordController.text);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xff024a06),
                            padding: EdgeInsets.symmetric(
                              vertical: screenHeight * 0.02,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text(
                            "SIGN UP",
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("You have an account? "),
                            GestureDetector(
                              onTap: () {
                                Get.off(SignInScreen());
                              },
                              child: const Text(
                                "Sign In",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff024a06),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              top: screenHeight * 0.45,
              left: 0,
              right: 0,
              child: Center(
                child: CircleAvatar(
                  radius: screenWidth * 0.12,
                  backgroundImage: NetworkImage(
                    "https://images.pexels.com/photos/3689532/pexels-photo-3689532.jpeg",
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
