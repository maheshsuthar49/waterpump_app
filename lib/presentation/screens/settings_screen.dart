import 'package:flutter/material.dart';
import 'package:water_pump/model/devices.dart';
import 'package:water_pump/presentation/widgets/edit_device.dart';

class SettingsScreen extends StatefulWidget {
  final DevicesData deviceData;
  SettingsScreen({required this.deviceData});
  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {

    super.initState();
    tabController = TabController(length: 3, vsync: this);
  }
  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(

        children: [
          TabBar(
            controller: tabController,
            isScrollable: true,
            tabAlignment:TabAlignment.center,
            indicatorColor: Color(0xff024a06),
            labelColor: Color(0xff024a06),
            labelStyle:TextStyle(fontWeight: FontWeight.bold),
            indicatorSize: TabBarIndicatorSize.label,
            tabs: [
              Tab(child: Text("Edit device")),
              Tab(child: Text("Device Configuration")),
              Tab(child: Text("Analog Limits")),
            ],
          ),
          Expanded(
            child: TabBarView(
                controller: tabController,
                children: [
                  EditDevice(devicesData: widget.deviceData,),

              /// 2. Device Config
              Center(
                child: Text(
                  "Device Config Content",
                  style: TextStyle(fontSize: 18),
                ),
              ),

              /// 3. Analog Limits
              Center(
                child: Text(
                  "Analog Limits Content",
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ]),
          )
        ],
      ),
    );
  }
}
