import 'package:flutter/material.dart';
import 'package:flutter_callkit_incoming/flutter_callkit_incoming.dart';
import 'package:get/get.dart';
import 'package:water_pump/controller/controller.dart';
import 'package:water_pump/presentation/screens/dashboard_screen.dart';
import 'package:water_pump/presentation/screens/signin_screen.dart';
import 'package:water_pump/presentation/widgets/wave_clipper.dart';
class WelcomeScreen extends StatelessWidget {
  final controller = Get.find<TaskController>();

   WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
   // final screenWidth = MediaQuery.of(context).size.width;
    final token = controller.box.read("token");
    Future.delayed(Duration(milliseconds: 500), () async {
      var calls = await FlutterCallkitIncoming.activeCalls();
      if(calls is List && calls.isNotEmpty){
       // print("Active call detected via Welcome Screen - Aborting Dashboard navigation");
      return;
      }
      if (token != null && token.toString().isNotEmpty) {
        await controller.fetchDeviceAll(token);
        Get.offAll(() => DashboardScreen(), transition: Transition.fadeIn);
      } else {
       // print("Token not found");
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
                    child:const Text(
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
                     const SizedBox(height: 20),
                     const Text(
                        "Wellcome",
                        style: TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                     const SizedBox(height: 10,),
                     const Text(
                        "Thank-you for choosing,\nAgromation India. Hope you have a\ngood experience.",
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                      const Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          if(token == null)...[
                           const Text(
                              'Continue',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        const  SizedBox(width: 10),
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
                              child: const Icon(
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
