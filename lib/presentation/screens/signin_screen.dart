import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:water_pump/controller/controller.dart';
import 'package:water_pump/presentation/screens/dashboard_screen.dart';
import 'package:water_pump/services/api_service.dart';


class SignInScreen extends StatelessWidget {
  final controller =  Get.find<TaskController>();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
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
                  child: Image.asset("assets/images/sigin.jpg",fit: BoxFit.cover,)
                ),
                Container(
                  height: screenHeight * 0.5,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  padding: EdgeInsets.all(screenWidth * 0.08),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: screenHeight * 0.05),
                      const Text(
                        "USERNAME / REGISTERED MOBILE NUMBER",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextFormField(
                        controller: usernameController,
                        decoration: const InputDecoration(
                          hintText: "aggromationindia@gmail.com",
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
                          hintText: "***********",
                          border: UnderlineInputBorder(),
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.05),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () async{
                            final username = usernameController.text;
                            final password = passwordController.text;
                            final token = await controller.apiService.login(username, password);

                            if(token != null){
                              await controller.box.write("token", token);
                              Get.snackbar("Success", "Login successfully");
                              await controller.fetchDeviceAll(token);
                              Get.offAll(DashboardScreen());
                            }else{
                              Get.snackbar("Error", "Invalid credentials");
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xff024a06),
                            padding: EdgeInsets.symmetric(vertical: screenHeight * 0.02),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text(
                            "SIGN IN",
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Don't have an account? "),
                            GestureDetector(
                              onTap: () {
                              },
                              child: const Text(
                                "Sign up",
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
                  backgroundImage: AssetImage("assets/images/agromation.jpg")
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}