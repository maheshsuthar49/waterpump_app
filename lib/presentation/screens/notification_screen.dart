import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:water_pump/controller/controller.dart';
class NotificationScreen extends StatelessWidget {
   NotificationScreen({super.key});
  final TaskController controller = Get.find<TaskController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: ()=> Get.back(), icon: Icon(Icons.arrow_back)),
        title: const Text(
          "Notifications",
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: Color(0xff024a06),
          ),
        ),
        centerTitle: true,
        actions: [
          TextButton(onPressed: () {

          }, child: Text("Marks all read", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400, letterSpacing: 0.2, color:Color(0xff024a06), ),))
        ],
      ),
      body: SafeArea(child: Obx(() {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView.builder(
              itemCount: controller.connectedList.length,
              itemBuilder: (context, index) {
                final device = controller.connectedList[index];
                final faultMsg = controller.buildFaultMessage(device);
                return
                  Column(
                    children: [
                      if(faultMsg.isNotEmpty)...[
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.grey.shade100,
                              border: Border.all(color: Colors.grey.shade300),
                              borderRadius: BorderRadius.circular(12)
                          ),
                          child: ListTile(
                            contentPadding: const EdgeInsets.all(16),
                            leading: Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                  color: Colors.red[100],
                                  shape:BoxShape.circle
                              ),
                              child: Icon(Icons.warning_amber_outlined, color: Colors.red,),
                            ),
                            title: Text(device.name, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),),
                            subtitle: Text(faultMsg,style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),),
                          ),
                        ),
                        SizedBox(height: 10,),
                      ],

                    ],
                  );}),
        );
      },)
      ),
    );
  }

}
