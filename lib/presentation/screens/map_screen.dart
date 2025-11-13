import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:water_pump/controller/controller.dart';

class MapScreen extends StatefulWidget {
  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  bool isMapLoading = true;
  final Completer<GoogleMapController> _mapController = Completer();
  Uint8List? markerIcon;

  final Set<Marker> _marker = {};

  final TaskController controller = Get.find<TaskController>();

  static const CameraPosition _cameraPosition = CameraPosition(
    target: LatLng(25.7781, 73.3311),
    zoom: 2
  );

  @override
  void initState() {
    super.initState();

      loadMap();

  }

  Future<void> loadMarker() async{

    if(controller.isLoading == false && controller.devices.isNotEmpty){
      try{
        final Uint8List icon = await getBytesFromAssets("assets/images/pump.png", 50);
        setState(() {
          markerIcon = icon;
          addDeviceMarker();
        });
      }catch (e){
          print("Error loading marker icon : $e");
      }
    }

  }

  Future<void> loadMap() async{
    Future.delayed(Duration(seconds: 1));

    Future<void> delayFuture = Future.delayed(Duration(seconds: 1));
    Future<void> loadFutureMarker = loadMarker();
    await Future.wait([delayFuture, loadFutureMarker]);

    setState(() {
      isMapLoading = false;
    });
}
  //convert image assets to unit8List
  Future<Uint8List> getBytesFromAssets(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
      targetHeight: width
    );
    ui.FrameInfo fi = await codec.getNextFrame();
    return(await fi.image.toByteData(format: ui.ImageByteFormat.png))!.buffer.asUint8List();
  }

  //add marker
  void addDeviceMarker(){
    if(markerIcon == null) return;
    _marker.clear();

    for(var i = 0; i < controller.devices.length; i++){
      final device = controller.devices[i];

      if(device.lat != null && device.lng != null ){
        _marker.add(
          Marker(markerId: MarkerId(device.uuid.toString()),
          position: LatLng(device.lat, device.lng),
            icon: BitmapDescriptor.bytes(markerIcon!),
            infoWindow: InfoWindow(title: device.name, snippet: device.area)
          )
        );
        setState(() {

        });
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Devices Location",
            style: TextStyle(fontWeight: FontWeight.w500,color: Color(0xff024a06), ),
          ),
          backgroundColor: Colors.white,
          centerTitle: true,
        ),
        body:
        isMapLoading ? Center(child: CircularProgressIndicator(color: Color(0xff024a06),),) :
    SafeArea(
      child: GoogleMap(initialCameraPosition: _cameraPosition,
        mapType: MapType.normal,
        markers: Set<Marker>.of(_marker),
        zoomControlsEnabled: false,

        onMapCreated: (GoogleMapController controller) {
        _mapController.complete(controller);

        },
      ),
    ));
  }
}
