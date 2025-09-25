import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DrawerScreen extends StatelessWidget{
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
                backgroundImage: NetworkImage(
                  "https://images.pexels.com/photos/3689532/pexels-photo-3689532.jpeg",
                ),
              ), SizedBox(width: 10,), Text("AGGROMATION INDIA PVT.\nLMT.", style: TextStyle(fontWeight: FontWeight.bold),)],
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
                Text("MAHESH KUMAR SUTHAR",style: TextStyle(fontWeight: FontWeight.bold),),
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
          children: [
            ListTile(
              leading: Icon(Icons.add_circle_outline, color: Colors.blue,),
              title: Text("Add New Device", style: TextStyle(color: Colors.blue),),
            ),
            ListTile(
              leading: Icon(Icons.circle, size: 10,color: Colors.grey,),
              title: Text("Jyoti"),
            ),
            ListTile(
              leading: Icon(Icons.circle, size: 10,color: Colors.grey,),
              title: Text("ofc test"),
            ),
            ListTile(
              leading: Icon(Icons.circle, size: 10,color: Colors.grey,),
              title: Text("test"),
            ),
            ListTile(
              leading: Icon(Icons.circle, size: 10,color: Colors.grey,),
              title: Text("PUPM10"),
            ),
            ListTile(
              leading: Icon(Icons.circle, size: 10,color: Colors.grey,),
              title: Text("PUMP2"),
            )
          ],
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
        )
      ],
    );
  }
}