import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:water_pump/controller/controller.dart';
import 'package:water_pump/presentation/screens/dashboard_screen.dart';
import 'package:water_pump/presentation/screens/signin_screen.dart';
import 'package:water_pump/presentation/widgets/wave_clipper.dart';

class WelcomeScreen extends StatelessWidget {
  final controller = Get.find<TaskController>();
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(milliseconds: 500), () async {
      final token = controller.box.read("token");
      if (token != null && token.toString().isNotEmpty) {
        await controller.fetchDeviceAll(token);
        Get.offAll(() => DashboardScreen(), transition: Transition.fadeIn);
      } else {
        print("Token not found");
      }
    });
    return Scaffold(
      body: Stack(
        children: [
          //top background Image
          Container(
            height: MediaQuery.of(context).size.height * 0.6,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/welcom.jpeg"),
                fit: BoxFit.cover,
              ),
            ),
            child: const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 50),
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage("assets/images/agromation.jpg"),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'IoT WATER PUMP\nCONTROLLER\nBY\nAGRROMATION\nINDIA',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      height: 1.3,
                    ),
                  ),
                ],
              ),
            ),
          ),

          //second container for wave clipper
          Align(
            alignment: Alignment.bottomCenter,
            child: ClipPath(
              clipper: WaveClipper(),
              child: Container(
                color: Colors.white,
                height: MediaQuery.of(context).size.height * 0.5,
                child: Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20),
                      Text(
                        "Wellcome",
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Thank-you for choosing,\nAgromation India. Hope you have a\ngood experience.",
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                      const Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          const Text(
                            'Continue',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 18,
                            ),
                          ),
                          SizedBox(width: 10),
                          FloatingActionButton(
                            onPressed: () {
                              Get.to(
                                SignInScreen(),
                                transition: Transition.rightToLeft,
                              );
                            },
                            backgroundColor: Color(0xff024a06),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Icon(
                              Icons.arrow_forward,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
