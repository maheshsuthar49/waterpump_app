import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ReportScreen extends StatelessWidget {
  TextEditingController dateController = TextEditingController();
  TextEditingController monthController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Card(
              elevation: 2,
              color: Colors.grey.shade100,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ExpansionTile(
                  collapsedShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  shape: RoundedRectangleBorder(side: BorderSide.none),
                  iconColor: Colors.grey.shade600,
                  title: Text(
                    "Daily Report",
                    style: TextStyle(
                      fontSize: 18,
                      color: Color(0xff024a06),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  leading: Icon(Icons.today, color: Colors.grey.shade600),
                  children: [
                    SizedBox(height: 10),
                    TextFormField(
                      controller: dateController,
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
                          dateController.text = DateFormat.yMMMd().format(
                            (value!),
                          );
                        },);
                      },
                      decoration: InputDecoration(
                        labelText: "Select Date",
                        border: OutlineInputBorder(),
                        suffixIcon: Icon(
                          Icons.calendar_month,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    //Table
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                        headingRowColor: WidgetStateProperty.all(
                          Color(0xffeafbea),
                        ),
                        border: TableBorder.all(color: Colors.grey.shade400),
                        columns: const [
                          DataColumn(
                            label: Expanded(
                              child: Text(
                                "Time (hr)",
                                style: TextStyle(fontSize: 16),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Expanded(
                              child: Text(
                                "Run (min)",
                                style: TextStyle(fontSize: 16),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Expanded(
                              child: Text(
                                "Power (kwh)",
                                style: TextStyle(fontSize: 16),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Expanded(
                              child: Text(
                                "Flow (l)",
                                style: TextStyle(fontSize: 16),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ],
                        rows: const [
                          DataRow(
                            cells: [
                              DataCell(
                                Center(child: Text("12:00 AM - 1:00 AM")),
                              ),
                              DataCell(Center(child: Text("45"))),
                              DataCell(Center(child: Text("1.2"))),
                              DataCell(Center(child: Text("150"))),
                            ],
                          ),
                          DataRow(
                            cells: [
                              DataCell(
                                Center(child: Text("12:00 AM - 1:00 AM")),
                              ),
                              DataCell(Center(child: Text("45"))),
                              DataCell(Center(child: Text("1.2"))),
                              DataCell(Center(child: Text("150"))),
                            ],
                          ),
                          DataRow(
                            cells: [
                              DataCell(
                                Center(child: Text("12:00 AM - 1:00 AM")),
                              ),
                              DataCell(Center(child: Text("45"))),
                              DataCell(Center(child: Text("1.2"))),
                              DataCell(Center(child: Text("150"))),
                            ],
                          ),
                          DataRow(
                            cells: [
                              DataCell(
                                Center(child: Text("12:00 AM - 1:00 AM")),
                              ),
                              DataCell(Center(child: Text("45"))),
                              DataCell(Center(child: Text("1.2"))),
                              DataCell(Center(child: Text("150"))),
                            ],
                          ),
                          DataRow(
                            cells: [
                              DataCell(
                                Center(child: Text("12:00 AM - 1:00 AM")),
                              ),
                              DataCell(Center(child: Text("45"))),
                              DataCell(Center(child: Text("1.2"))),
                              DataCell(Center(child: Text("150"))),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xff024a06),
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            onPressed: () {},
                            child: Text("Get"),
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xff024a06),
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            onPressed: () {},
                            child: Text("Export"),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10),
            Card(
              elevation: 2,
              color: Colors.grey.shade100,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ExpansionTile(
                  collapsedShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  shape: RoundedRectangleBorder(side: BorderSide.none),
                  iconColor: Colors.grey.shade600,
                  title: Text(
                    "Monthly Report",
                    style: TextStyle(
                      fontSize: 18,
                      color: Color(0xff024a06),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  leading: Icon(
                    Icons.calendar_month,
                    color: Colors.grey.shade600,
                  ),
                  children: [
                    SizedBox(height: 10),
                    TextFormField(
                      controller: monthController,
                      keyboardType: TextInputType.text,
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
                        ).then((date) {
                          monthController.text = DateFormat.yMMM().format(
                            (date!),
                          );
                        },);
                      },
                      decoration: InputDecoration(
                        labelText: "Select Month",
                        border: OutlineInputBorder(),
                        suffixIcon: Icon(
                          Icons.calendar_month,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    //Table
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                        headingRowColor: WidgetStateProperty.all(
                          Color(0xffeafbea),
                        ),
                        border: TableBorder.all(color: Colors.grey.shade400),
                        columns: const [
                          DataColumn(
                            label: Expanded(
                              child: Text(
                                "Date",
                                style: TextStyle(fontSize: 16),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Expanded(
                              child: Text(
                                "Run (min)",
                                style: TextStyle(fontSize: 16),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Expanded(
                              child: Text(
                                "Power (kwh)",
                                style: TextStyle(fontSize: 16),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Expanded(
                              child: Text(
                                "Flow (l)",
                                style: TextStyle(fontSize: 16),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ],
                        rows: const [
                          DataRow(
                            cells: [
                              DataCell(Center(child: Text("1/12"))),
                              DataCell(Center(child: Text("1200"))),
                              DataCell(Center(child: Text("35"))),
                              DataCell(Center(child: Text("4500"))),
                            ],
                          ),
                          DataRow(
                            cells: [
                              DataCell(Center(child: Text("1/12"))),
                              DataCell(Center(child: Text("1200"))),
                              DataCell(Center(child: Text("35"))),
                              DataCell(Center(child: Text("4500"))),
                            ],
                          ),
                          DataRow(
                            cells: [
                              DataCell(Center(child: Text("1/12"))),
                              DataCell(Center(child: Text("1200"))),
                              DataCell(Center(child: Text("35"))),
                              DataCell(Center(child: Text("4500"))),
                            ],
                          ),
                          DataRow(
                            cells: [
                              DataCell(Center(child: Text("1/12"))),
                              DataCell(Center(child: Text("1200"))),
                              DataCell(Center(child: Text("35"))),
                              DataCell(Center(child: Text("4500"))),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xff024a06),
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            onPressed: () {},
                            child: Text("Get"),
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xff024a06),
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            onPressed: () {},
                            child: Text("Export"),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
