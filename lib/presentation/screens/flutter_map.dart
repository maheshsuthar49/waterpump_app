import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:water_pump/controller/controller.dart';


class FMaps extends StatefulWidget {
  const FMaps({super.key});

  @override
  State<FMaps> createState() => _FlutterMapsState();
}

class _FlutterMapsState extends State<FMaps> {
  final TaskController controller = Get.find<TaskController>();
  bool isFMapLoading = true;
  static const LatLng _initialCenter  = LatLng(25.7781, 73.3311);
  static const double _initialZoom = 4.0;

  @override
  void initState() {
    super.initState();
    if(controller.isLoading.isFalse && controller.devices.isNotEmpty){
      isFMapLoading = false;
    } else{
      Future.delayed(Duration(milliseconds: 500), () {
        if(mounted){
          setState(() {
            isFMapLoading = false;
          });
        }
      },);
    }
  }
  List<Marker> deviceMarkers(){
    List<Marker> markers = [];
    if(controller.devices.isEmpty){
      return markers;
    }
    for(var device in controller.devices){
      if(device.lat != null && device.lng != null){
        markers.add(
         Marker(point: LatLng(device.lat, device.lng), width: 50, height: 50, child: GestureDetector(
             onTap: () {
               ScaffoldMessenger.of(context).showSnackBar(
                 SnackBar(content: Text("${device.name}, ${device.area}",style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),backgroundColor: Colors.white, duration: Duration(seconds: 3),)
               );
             },
             child: Image.asset("assets/images/pump.png",fit: BoxFit.contain,)))
        );
      }
    }
    return markers;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Device Location",
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: Color(0xff024a06),
          ),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body: isFMapLoading ? Center(child: CircularProgressIndicator(color: Color(0xff024a06),),)

      : SafeArea(
        child: FlutterMap(
          options: MapOptions(
            initialCenter: LatLng(20.5937, 78.9629),
            initialZoom: 4.0,
          ),
          children: [
            TileLayer(
              urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
              userAgentPackageName: 'com.example.water_pump',
            ),
            
            Obx(() {
              return MarkerLayer(markers: deviceMarkers());
            },)
          ],
        ),
      ),
    );
  }
}
