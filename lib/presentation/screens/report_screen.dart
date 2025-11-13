import 'dart:io';

import 'package:excel/excel.dart';
import 'package:external_path/external_path.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:open_filex/open_filex.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:water_pump/controller/controller.dart';
import 'package:water_pump/model/devices.dart';
import 'package:water_pump/model/reports_data.dart';
import 'package:water_pump/shared/custome_button.dart';

class ReportScreen extends StatefulWidget {
  final DevicesData deviceData;
  ReportScreen({required this.deviceData});

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  final controller = Get.find<TaskController>();

  TextEditingController fromDateController = TextEditingController();

  TextEditingController toDateController = TextEditingController();
  final List<Map<String, dynamic>> _timeList = [
    {'time': '12:00 AM'},
    {'time': '12:15 AM'},
    {'time': '12:30 AM'},
    {'time': '12:45 AM'},
    {'time': '01:00 AM'},
    {'time': '01:15 AM'},
    {'time': '01:30 AM'},
    {'time': '01:45 AM'},
    {'time': '02:00 AM'},
    {'time': '02:15 AM'},
    {'time': '02:30 AM'},
    {'time': '02:45 AM'},
    {'time': '03:00 AM'},
    {'time': '03:15 AM'},
    {'time': '03:30 AM'},
    {'time': '03:45 AM'},
    {'time': '04:00 AM'},
    {'time': '04:15 AM'},
    {'time': '04:30 AM'},
    {'time': '04:45 AM'},
    {'time': '05:00 AM'},
    {'time': '05:15 AM'},
    {'time': '05:30 AM'},
    {'time': '05:45 AM'},
    {'time': '06:00 AM'},
    {'time': '06:15 AM'},
    {'time': '06:30 AM'},
    {'time': '06:45 AM'},
    {'time': '07:00 AM'},
    {'time': '07:15 AM'},
    {'time': '07:30 AM'},
    {'time': '07:45 AM'},
    {'time': '08:00 AM'},
    {'time': '08:15 AM'},
    {'time': '08:30 AM'},
    {'time': '08:45 AM'},
    {'time': '09:00 AM'},
    {'time': '09:15 AM'},
    {'time': '09:30 AM'},
    {'time': '09:45 AM'},
    {'time': '10:00 AM'},
    {'time': '10:15 AM'},
    {'time': '10:30 AM'},
    {'time': '10:45 AM'},
    {'time': '11:00 AM'},
    {'time': '11:15 AM'},
    {'time': '11:30 AM'},
    {'time': '11:45 AM'},
    {'time': '12:00 PM'},
    {'time': '12:15 PM'},
    {'time': '12:30 PM'},
    {'time': '12:45 PM'},
    {'time': '01:00 PM'},
    {'time': '01:15 PM'},
    {'time': '01:30 PM'},
    {'time': '01:45 PM'},
    {'time': '02:00 PM'},
    {'time': '02:15 PM'},
    {'time': '02:30 PM'},
    {'time': '02:45 PM'},
    {'time': '03:00 PM'},
    {'time': '03:15 PM'},
    {'time': '03:30 PM'},
    {'time': '03:45 PM'},
    {'time': '04:00 PM'},
    {'time': '04:15 PM'},
    {'time': '04:30 PM'},
    {'time': '04:45 PM'},
    {'time': '05:00 PM'},
    {'time': '05:15 PM'},
    {'time': '05:30 PM'},
    {'time': '05:45 PM'},
    {'time': '06:00 PM'},
    {'time': '06:15 PM'},
    {'time': '06:30 PM'},
    {'time': '06:45 PM'},
    {'time': '07:00 PM'},
    {'time': '07:15 PM'},
    {'time': '07:30 PM'},
    {'time': '07:45 PM'},
    {'time': '08:00 PM'},
    {'time': '08:15 PM'},
    {'time': '08:30 PM'},
    {'time': '08:45 PM'},
    {'time': '09:00 PM'},
    {'time': '09:15 PM'},
    {'time': '09:30 PM'},
    {'time': '09:45 PM'},
    {'time': '10:00 PM'},
    {'time': '10:15 PM'},
    {'time': '10:30 PM'},
    {'time': '10:45 PM'},
    {'time': '11:00 PM'},
    {'time': '11:15 PM'},
    {'time': '11:30 PM'},
    {'time': '11:45 PM'},
  ];
  @override
  void initState() {
    super.initState();
    controller.reportsDataList.clear();
  }

  Future<void> exportToExcel() async {
    if (controller.reportsDataList.isEmpty) {
      Get.snackbar(
        "Error",
        "No report data to export.",
        duration: Duration(seconds: 1),
        colorText: Colors.red,
      );
      return;
    }
    var excel = Excel.createExcel();
    Sheet sheetObj = excel.sheets.values.first;
    List<String> headers = [
      "Time",
      "R(v)",
      "Y(V)",
      "B(V)",
      "R(A)",
      "Y(A)",
      "B(A)",
      "Status",
      "Fault",
    ];
    for (int i = 0; i < headers.length; i++) {
      sheetObj
          .cell(CellIndex.indexByColumnRow(columnIndex: i, rowIndex: 0))
          .value = TextCellValue(
        headers[i],
      );
    }
    for (int i = 0; i < controller.reportsDataList.length; i++) {
      final reports = controller.reportsDataList[i];
      final timeSlots = (_timeList.length > i) ? _timeList[i]['time'] : 'N/A';
      sheetObj
          .cell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: i + 1))
          .value = TextCellValue(
        timeSlots,
      );
      sheetObj
          .cell(CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: i + 1))
          .value = TextCellValue(
        reports.vr.toString(),
      );
      sheetObj
          .cell(CellIndex.indexByColumnRow(columnIndex: 2, rowIndex: i + 1))
          .value = TextCellValue(
        reports.vy.toString(),
      );
      sheetObj
          .cell(CellIndex.indexByColumnRow(columnIndex: 3, rowIndex: i + 1))
          .value = TextCellValue(
        reports.vb.toString(),
      );
      sheetObj
          .cell(CellIndex.indexByColumnRow(columnIndex: 4, rowIndex: i + 1))
          .value = TextCellValue(
        reports.ir.toString(),
      );
      sheetObj
          .cell(CellIndex.indexByColumnRow(columnIndex: 5, rowIndex: i + 1))
          .value = TextCellValue(
        reports.iy.toString(),
      );
      sheetObj
          .cell(CellIndex.indexByColumnRow(columnIndex: 6, rowIndex: i + 1))
          .value = TextCellValue(
        reports.ib.toString(),
      );
      sheetObj
          .cell(CellIndex.indexByColumnRow(columnIndex: 7, rowIndex: i + 1))
          .value = TextCellValue(
        reports.statusText,
      );
      sheetObj
          .cell(CellIndex.indexByColumnRow(columnIndex: 8, rowIndex: i + 1))
          .value = TextCellValue(
        reports.faultText,
      );
    }

    try {
      List<int>? fileBytes = excel.save();
      if (fileBytes != null) {
        final directory = await ExternalPath.getExternalStoragePublicDirectory(
          ExternalPath.DIRECTORY_DOWNLOAD,
        );
        final fileName =
            "Reports_${widget.deviceData.name}_${DateFormat('yyyyMMdd_HHmmss').format(DateTime.now())}.xlsx";
        final filePath = '$directory/$fileName';
        final file = File(filePath);

        await file.create(recursive: true);
        await file.writeAsBytes(fileBytes!);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Report Download Successful",style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),backgroundColor: Colors.white,));

        await OpenFilex.open(filePath);
      } else {
        throw Exception("Failed to encode excel file");
      }
    } catch (e) {
      print("Error during export: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Card(
                elevation: 2,
                color: Colors.grey.shade100,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10),
                      Text(
                        "Daily Report",
                        style: TextStyle(
                          fontSize: 20,
                          color: Color(0xff024a06),
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      SizedBox(height: 10),
                      TextFormField(
                        controller: fromDateController,
                        keyboardType: TextInputType.datetime,
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return "Please select date";
                          }
                        },
                        readOnly: true,
                        onTap: () {
                          showDatePicker(
                            context: context,
                            firstDate: DateTime(2022),
                            lastDate: DateTime(2050),
                          ).then((value) {
                            fromDateController.text = DateFormat.yMMMd().format(
                              (value!),
                            );
                          });
                        },
                        decoration: InputDecoration(
                          labelText: "From Date",
                          border: OutlineInputBorder(),
                          suffixIcon: Icon(
                            Icons.calendar_month,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child:
                            CustomButton(text: "Get", onPressed: () async {
                              if (fromDateController.text.isEmpty) {
                                Get.snackbar(
                                  "Error",
                                  "Please select the Date",
                                  duration: Duration(seconds: 1),
                                  colorText: Colors.red,
                                );
                              }
                              final DateTime parsedDate = DateFormat.yMMMd()
                                  .parse(fromDateController.text);
                              final DateTime fromDateObj = parsedDate;
                              final DateTime toFromObj = DateTime(
                                parsedDate.year,
                                parsedDate.month,
                                parsedDate.day,
                                23,
                                59,
                                59,
                                999,
                                999,
                              );
                              final DateFormat apiFormatter = DateFormat(
                                "yyyy-MM-dd HH:mm:ss:SSSSSS",
                              );
                              final id = widget.deviceData.id.toString();
                              final String fromDate = apiFormatter.format(
                                fromDateObj,
                              );
                              final String toDate = apiFormatter.format(
                                toFromObj,
                              );
                              await controller.fetchReport(
                                id: widget.deviceData.id.toString(),
                                from: fromDate,
                                to: toDate,
                              );
                            }
                        )
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: CustomButton(text: "Export", onPressed: exportToExcel)

                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10),
              Obx(() {
                if (controller.isReportLoading.value) {
                  return Center(
                    child: CircularProgressIndicator(color: Color(0xff024a06)),
                  );
                }
                if (controller.reportsDataList.isEmpty) {
                  return SizedBox.shrink();
                }
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTableTheme(
                    data: DataTableThemeData(
                      headingRowHeight: 40,
                      dataRowMaxHeight: 20,
                      dataRowMinHeight: 10,

                    ),
                    child: DataTable(
                      columnSpacing: 20.0,
                      headingRowColor: WidgetStateProperty.all(Color(0xffeafbea)),
                      border: TableBorder.all(color: Colors.grey.shade400),
                      columns: const [
                        DataColumn(
                          label: Expanded(
                            child: Text(
                              "Time",
                              style: TextStyle(fontSize: 16),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Expanded(
                            child: Text(
                              "R(v)",
                              style: TextStyle(fontSize: 16),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Expanded(
                            child: Text(
                              "Y(V)",
                              style: TextStyle(fontSize: 16),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Expanded(
                            child: Text(
                              "B(V)",
                              style: TextStyle(fontSize: 16),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Expanded(
                            child: Text(
                              "R(A)",
                              style: TextStyle(fontSize: 16),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Expanded(
                            child: Text(
                              "Y(A)",
                              style: TextStyle(fontSize: 16),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Expanded(
                            child: Text(
                              "B(A)",
                              style: TextStyle(fontSize: 16),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Expanded(
                            child: Text(
                              "Status",
                              style: TextStyle(fontSize: 16),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Expanded(
                            child: Text(
                              "Fault",
                              style: TextStyle(fontSize: 16),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ],
                      rows: controller.reportsDataList.asMap().entries.map((
                        entry,
                      ) {
                        final int index = entry.key;
                        final ReportsData reportData = entry.value;
                        final String timeSlot = (index < _timeList.length)
                            ? _timeList[index]['time']
                            : "N/A";
                        return DataRow(

                          cells: [
                            DataCell(Center(child: Text(timeSlot))),
                            DataCell(
                              Center(child: Text(reportData.vr.toString())),
                            ),
                            DataCell(
                              Center(child: Text(reportData.vy.toString())),
                            ),
                            DataCell(
                              Center(child: Text(reportData.vb.toString())),
                            ),
                            DataCell(
                              Center(child: Text(reportData.ir.toString())),
                            ),
                            DataCell(
                              Center(child: Text(reportData.iy.toString())),
                            ),
                            DataCell(
                              Center(child: Text(reportData.ib.toString())),
                            ),
                            DataCell(Center(child: Text(reportData.statusText))),
                            DataCell(Center(child: Text(reportData.faultText))),
                          ],
                        );
                      }).toList(),
                    ),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
