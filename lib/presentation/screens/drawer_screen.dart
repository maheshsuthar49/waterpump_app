import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:water_pump/controller/controller.dart';
import 'package:water_pump/model/devices.dart';
import 'package:water_pump/presentation/screens/dashboard_screen.dart';
import 'package:water_pump/presentation/screens/device_detail.dart';
import 'package:water_pump/presentation/screens/signin_screen.dart';

class DrawerScreen extends StatelessWidget{
  final controller = Get.find<TaskController>();

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        DrawerHeader(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              children: [CircleAvatar(
                radius: 24,
                backgroundImage: AssetImage("assets/images/agromation.jpg")
              ), SizedBox(width: 10,), Flexible(fit: FlexFit.tight, child: Text("AGROMATION INDIA PVT.LMT.", style: TextStyle(fontWeight: FontWeight.bold),))],
            ),
            SizedBox(height: 10,),
            Row(
              children: [
                CircleAvatar(
                  radius: 18,
                  backgroundColor:Colors.grey.shade600,
                  child: Icon(Icons.person, color: Colors.white,),
                ), 
                SizedBox(width: 10,),
                Flexible(fit: FlexFit.tight, child: Text("MAHESH KUMAR SUTHAR",style: TextStyle(fontWeight: FontWeight.bold),)),
                Icon(Icons.verified_user, color: Color(0xff024a06),size: 18,)
              ],
            ),
            
          ],
        )) ,

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text("Your app",style: TextStyle(color: Colors.grey.shade600,fontWeight: FontWeight.w500),),
        ),
        ListTile(
          leading: Icon(Icons.history,color: Colors.grey.shade600,),
          title: Text("Your Activity"),
          onTap: (){},
        ),
        ListTile(
          leading: Icon(Icons.settings,color: Colors.grey.shade600,),
          title: Text("Settings"),
          onTap: (){},
        ),
        
        //dropdown for devices using expention widget
        ExpansionTile(
         iconColor: Colors.grey.shade600,
          title: Text("Your Devices"),
        leading: Icon(Icons.devices,color: Colors.grey.shade600,),
          children: controller.devices.map((device) {
            return  ListTile(
              leading: Icon(Icons.circle, size: 10,color: device.isConnected ? Color(0xff024a06) : Colors.grey,),
              title: Text(device.name),

            );
          },).toList()
        ),
        ListTile(
          leading: Icon(Icons.info, color: Colors.grey.shade600,),
          title: Text("About"),
          onTap: (){},
        ),
        const Divider(),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text("Help",style: TextStyle(color: Colors.grey.shade600,fontWeight: FontWeight.w500),),
        ),
        ListTile(
          leading: Icon(Icons.phone_outlined,color: Colors.grey.shade600,),
          title: Text("Call Support Team"),
        ),

        const Divider(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text("Login",style: TextStyle(color: Colors.grey.shade600, fontWeight: FontWeight.w500),),
        ),
        ListTile(
          leading: Icon(Icons.person_add_alt,color: Colors.blue,),
          title: Text("Add Account",style: TextStyle(color: Colors.blue),),
        ),

        ListTile(
          leading: Icon(Icons.logout,color: Colors.red,),
          title: Text("Log out",style: TextStyle(color: Colors.red),),
          onTap: () {
            controller.box.remove('token');
            Get.offAll(SignInScreen(), transition: Transition.leftToRight);
          },
        )
      ],
    );
  }
}