import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:water_pump/controller/controller.dart';

class AnalogLimits extends StatefulWidget {
  @override
  State<AnalogLimits> createState() => _AnalogLimitsState();
}

class _AnalogLimitsState extends State<AnalogLimits> {
  int? expendedTileIndex;
  final controller = Get.find<TaskController>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: ListView(
        children: [
          Card(
            elevation: 2,
            color: Colors.grey.shade100,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ExpansionTile(
                key: UniqueKey(),
                initiallyExpanded: expendedTileIndex == 0,
                onExpansionChanged: (expanded) {
                  setState(() {
                    expendedTileIndex = expanded ? 0 : null;
                  });
                },
                collapsedShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                shape: RoundedRectangleBorder(side: BorderSide.none),
                iconColor: Colors.grey.shade600,
                title: Text(
                  "Voltage(R)",
                  style: TextStyle(
                    fontSize: 18,
                    color: Color(0xff024a06),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                leading: Icon(Icons.bolt, color: Colors.grey.shade600),
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Status",
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                        ),
                      ),
                      Switch(
                        activeColor: Color(0xff024a06),
                        value: controller.power.value,
                        onChanged: (value) {},
                      ),
                    ],
                  ),
                  Divider(height: 4),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10),
                      Text(
                        "Minimum",
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                        ),
                        textAlign: TextAlign.start,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          isDense: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Maximum",
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                        ),
                        textAlign: TextAlign.start,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          isDense: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Multiplier",
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                        ),
                        textAlign: TextAlign.start,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          isDense: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xff024a06),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          onPressed: () {},
                          child: Text("Update"),
                        ),
                      ),
                    ],
                  ),
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
                key: UniqueKey(),
                initiallyExpanded: expendedTileIndex == 1,
                onExpansionChanged: (expanded) {
                  setState(() {
                    expendedTileIndex = expanded ? 1 : null;
                  });
                },
                collapsedShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                shape: RoundedRectangleBorder(side: BorderSide.none),
                iconColor: Colors.grey.shade600,
                title: Text(
                  "Voltage(Y)",
                  style: TextStyle(
                    fontSize: 18,
                    color: Color(0xff024a06),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                leading: Icon(Icons.bolt, color: Colors.grey.shade600),
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Status",
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                        ),
                      ),
                      Switch(
                        activeColor: Color(0xff024a06),
                        value: controller.power.value,
                        onChanged: (value) {},
                      ),
                    ],
                  ),
                  Divider(height: 4),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10),
                      Text(
                        "Minimum",
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                        ),
                        textAlign: TextAlign.start,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          isDense: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Maximum",
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                        ),
                        textAlign: TextAlign.start,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          isDense: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Multiplier",
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                        ),
                        textAlign: TextAlign.start,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          isDense: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xff024a06),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          onPressed: () {},
                          child: Text("Update"),
                        ),
                      ),
                    ],
                  ),
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
                key: UniqueKey(),
                initiallyExpanded: expendedTileIndex == 2,
                onExpansionChanged: (expanded) {
                  setState(() {
                    expendedTileIndex = expanded ? 2 : null;
                  });
                },
                collapsedShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                shape: RoundedRectangleBorder(side: BorderSide.none),
                iconColor: Colors.grey.shade600,
                title: Text(
                  "Voltage(B)",
                  style: TextStyle(
                    fontSize: 18,
                    color: Color(0xff024a06),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                leading: Icon(Icons.bolt, color: Colors.grey.shade600),
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Status",
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                        ),
                      ),
                      Switch(
                        activeColor: Color(0xff024a06),
                        value: controller.power.value,
                        onChanged: (value) {},
                      ),
                    ],
                  ),
                  Divider(height: 4),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10),
                      Text(
                        "Minimum",
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                        ),
                        textAlign: TextAlign.start,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          isDense: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Maximum",
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                        ),
                        textAlign: TextAlign.start,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          isDense: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Multiplier",
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                        ),
                        textAlign: TextAlign.start,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          isDense: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xff024a06),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          onPressed: () {},
                          child: Text("Update"),
                        ),
                      ),
                    ],
                  ),
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
                key: UniqueKey(),
                initiallyExpanded: expendedTileIndex == 3,
                onExpansionChanged: (expanded) {
                  setState(() {
                    expendedTileIndex = expanded ? 3 : null;
                  });
                },
                collapsedShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                shape: RoundedRectangleBorder(side: BorderSide.none),
                iconColor: Colors.grey.shade600,
                title: Text(
                  "Current(R)",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                leading: Icon(Icons.power, color: Colors.grey.shade600),
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Status",
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                        ),
                      ),
                      Switch(
                        activeColor: Color(0xff024a06),
                        value: controller.power.value,
                        onChanged: (value) {},
                      ),
                    ],
                  ),
                  Divider(height: 4),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10),
                      Text(
                        "Minimum",
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                        ),
                        textAlign: TextAlign.start,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          isDense: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Maximum",
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                        ),
                        textAlign: TextAlign.start,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          isDense: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Multiplier",
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                        ),
                        textAlign: TextAlign.start,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          isDense: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xff024a06),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          onPressed: () {},
                          child: Text("Update"),
                        ),
                      ),
                    ],
                  ),
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
                key: UniqueKey(),
                initiallyExpanded: expendedTileIndex == 4,
                onExpansionChanged: (expanded) {
                  setState(() {
                    expendedTileIndex = expanded ? 4 : null;
                  });
                },
                collapsedShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                shape: RoundedRectangleBorder(side: BorderSide.none),
                iconColor: Colors.grey.shade600,
                title: Text(
                  "Current(Y)",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                leading: Icon(Icons.power, color: Colors.grey.shade600),
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Status",
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                        ),
                      ),
                      Switch(
                        activeColor: Color(0xff024a06),
                        value: controller.power.value,
                        onChanged: (value) {},
                      ),
                    ],
                  ),
                  Divider(height: 4),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10),
                      Text(
                        "Minimum",
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                        ),
                        textAlign: TextAlign.start,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          isDense: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Maximum",
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                        ),
                        textAlign: TextAlign.start,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          isDense: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Multiplier",
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                        ),
                        textAlign: TextAlign.start,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          isDense: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xff024a06),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          onPressed: () {},
                          child: Text("Update"),
                        ),
                      ),
                    ],
                  ),
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
                key: UniqueKey(),
                initiallyExpanded: expendedTileIndex == 5,
                onExpansionChanged: (expanded) {
                  setState(() {
                    expendedTileIndex = expanded ? 5 : null;
                  });
                },
                collapsedShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                shape: RoundedRectangleBorder(side: BorderSide.none),
                iconColor: Colors.grey.shade600,
                title: Text(
                  "Current(B)",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                leading: Icon(Icons.power, color: Colors.grey.shade600),
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Status",
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                        ),
                      ),
                      Switch(
                        activeColor: Color(0xff024a06),
                        value: controller.power.value,
                        onChanged: (value) {},
                      ),
                    ],
                  ),
                  Divider(height: 4),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10),
                      Text(
                        "Minimum",
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                        ),
                        textAlign: TextAlign.start,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          isDense: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Maximum",
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                        ),
                        textAlign: TextAlign.start,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          isDense: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Multiplier",
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                        ),
                        textAlign: TextAlign.start,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          isDense: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xff024a06),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          onPressed: () {},
                          child: Text("Update"),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
