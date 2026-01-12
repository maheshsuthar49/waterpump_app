import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:water_pump/controller/controller.dart';
import 'package:water_pump/model/devices.dart';

class ApiService {
  final Dio _dio = Dio(BaseOptions(baseUrl: "https://mc.shreeiot.com/api"));
  //LoginAPI
  Future<String?> login(String username, String password) async {
    try {
      final response = await _dio.post(
        "/login",
        data: {"username": username, "password": password},
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.data);
        String token = data['token'];
        //print(data);

        return token;
      } else {
        //print("Login failed : ${response.data}");
      }
    } catch (e) {
      //print("login error: $e");
    }

    return null;
  }

  //getDevices
  Future<Device?> getDevices(String token) async {

    try {
      final response = await _dio.get(
        "/getDevices",
        options: Options(headers: {"Authorization": " $token"}),
      );
      
      if (response.statusCode == 200) {
       // print("Get Devices Success: ${response.data}");
        final jsonData = response.data is String
        ? jsonDecode(response.data) : response.data;
        return Device.fromJson(jsonData);
      } else {
       // print("Get Devices failed :${response.data}");
      }
    }catch (e){
      //print("Get devices error: $e");
    }
    return null;
  }

  //get Report

Future<List<Map<String, dynamic>>?> getReport ({required String token, required String id, required String from, required String to }) async{
    try{
      final response = await _dio.post("/getReportData",
        data: {
        "id": id,
          "from": from,
          "to":to,
        },
          options: Options(headers: {"Authorization": " $token"}),
      );

      if(response.statusCode == 200){
       // print("Report get from: ${response.data}");
        final responseData =  response.data is String
        ? jsonDecode(response.data) : response.data;
        if(responseData['success'] == true && responseData['data'] != null){
          List<Map<String, dynamic>> dataList = List<Map<String, dynamic>>.from(responseData['data']);
          return dataList;
        }
      }else{
        //print("Failed to get report:  ${response.statusCode}");
      }
    }catch (e){
      //print("Error to get report: $e");
    }
    return null;
}
}
