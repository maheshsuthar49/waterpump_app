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
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final token = controller.box.read("token");
    Future.delayed(Duration(seconds: 2), () async {

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
            height: screenHeight * 0.6,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/welcom.jpeg"),
                fit: BoxFit.cover,
              ),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: screenHeight * 0.07,),
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage("assets/images/agromation.jpg"),
                  ),
                  SizedBox(height: screenHeight * 0.05),
                  Flexible(
                    fit: FlexFit.tight,
                    child: Text(
                      'IoT WATER PUMP\nCONTROLLER\nBY\nAGRROMATION\nINDIA',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        height: 1.3,
                      ),
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
                height:screenHeight * 0.5,
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
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10,),
                      Text(
                        "Thank-you for choosing,\nAgromation India. Hope you have a\ngood experience.",
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                      const Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          if(token == null)...[
                            Text(
                              'Continue',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 18,
                              ),
                            ),
                          ],
                          SizedBox(width: 10),
                          if(token == null)...[
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
    ]
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
