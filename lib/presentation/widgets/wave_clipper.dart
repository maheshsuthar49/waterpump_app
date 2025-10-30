import 'package:flutter/cupertino.dart';

class WaveClipper extends CustomClipper<Path>{
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height);
    path.lineTo(size.width,size.height);
    path.lineTo(size.width, 0);
    path.quadraticBezierTo(size.width / 2, 80, 0, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }

}

// SizedBox(height: 10)
// Card(
//   elevation: 2,
//   color: Colors.grey.shade100,
//   child: Padding(
//     padding: const EdgeInsets.all(8.0),
//     child: ExpansionTile(
//       key: UniqueKey(),
//       initiallyExpanded: expendedTileIndex == 1,
//       onExpansionChanged: (expanded) {
//         setState(() {
//           expendedTileIndex = expanded ? 1 : null;
//         });
//       },
//       collapsedShape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(16),
//       ),
//       shape: RoundedRectangleBorder(side: BorderSide.none),
//       iconColor: Colors.grey.shade600,
//       title: Text(
//         "Voltage(Y)",
//         style: TextStyle(
//           fontSize: 18,
//           color: Color(0xff024a06),
//           fontWeight: FontWeight.bold,
//         ),
//       ),
//       leading: Icon(Icons.bolt, color: Colors.grey.shade600),
//       children: [
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Text(
//               "Status",
//               style: TextStyle(
//                 fontWeight: FontWeight.w700,
//                 fontSize: 18,
//               ),
//             ),
//             Switch(
//               activeColor: Color(0xff024a06),
//               value: controller.power.value,
//               onChanged: (value) {},
//             ),
//           ],
//         ),
//         Divider(height: 4),
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             SizedBox(height: 10),
//             Text(
//               "Minimum",
//               style: TextStyle(
//                 fontWeight: FontWeight.w700,
//                 fontSize: 18,
//               ),
//               textAlign: TextAlign.start,
//             ),
//             TextFormField(
//               keyboardType: TextInputType.number,
//               decoration: InputDecoration(
//                 isDense: true,
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(6),
//                 ),
//                 focusedBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(6),
//                 ),
//               ),
//             ),
//             SizedBox(height: 10),
//             Text(
//               "Maximum",
//               style: TextStyle(
//                 fontWeight: FontWeight.w700,
//                 fontSize: 18,
//               ),
//               textAlign: TextAlign.start,
//             ),
//             TextFormField(
//               keyboardType: TextInputType.number,
//               decoration: InputDecoration(
//                 isDense: true,
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(6),
//                 ),
//                 focusedBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(6),
//                 ),
//               ),
//             ),
//             SizedBox(height: 10),
//             Text(
//               "Multiplier",
//               style: TextStyle(
//                 fontWeight: FontWeight.w700,
//                 fontSize: 18,
//               ),
//               textAlign: TextAlign.start,
//             ),
//             TextFormField(
//               keyboardType: TextInputType.number,
//               decoration: InputDecoration(
//                 isDense: true,
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(6),
//                 ),
//                 focusedBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(6),
//                 ),
//               ),
//             ),
//             SizedBox(height: 10),
//             SizedBox(
//               width: double.infinity,
//               child: ElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Color(0xff024a06),
//                   foregroundColor: Colors.white,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                 ),
//                 onPressed: () {},
//                 child: Text("Update"),
//               ),
//             ),
//           ],
//         ),
//       ],
//     ),
//   ),
// ),
// SizedBox(height: 10),
// Card(
//   elevation: 2,
//   color: Colors.grey.shade100,
//   child: Padding(
//     padding: const EdgeInsets.all(8.0),
//     child: ExpansionTile(
//       key: UniqueKey(),
//       initiallyExpanded: expendedTileIndex == 2,
//       onExpansionChanged: (expanded) {
//         setState(() {
//           expendedTileIndex = expanded ? 2 : null;
//         });
//       },
//       collapsedShape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(16),
//       ),
//       shape: RoundedRectangleBorder(side: BorderSide.none),
//       iconColor: Colors.grey.shade600,
//       title: Text(
//         "Voltage(B)",
//         style: TextStyle(
//           fontSize: 18,
//           color: Color(0xff024a06),
//           fontWeight: FontWeight.bold,
//         ),
//       ),
//       leading: Icon(Icons.bolt, color: Colors.grey.shade600),
//       children: [
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Text(
//               "Status",
//               style: TextStyle(
//                 fontWeight: FontWeight.w700,
//                 fontSize: 18,
//               ),
//             ),
//             Switch(
//               activeColor: Color(0xff024a06),
//               value: controller.power.value,
//               onChanged: (value) {},
//             ),
//           ],
//         ),
//         Divider(height: 4),
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             SizedBox(height: 10),
//             Text(
//               "Minimum",
//               style: TextStyle(
//                 fontWeight: FontWeight.w700,
//                 fontSize: 18,
//               ),
//               textAlign: TextAlign.start,
//             ),
//             TextFormField(
//               keyboardType: TextInputType.number,
//               decoration: InputDecoration(
//                 isDense: true,
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(6),
//                 ),
//                 focusedBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(6),
//                 ),
//               ),
//             ),
//             SizedBox(height: 10),
//             Text(
//               "Maximum",
//               style: TextStyle(
//                 fontWeight: FontWeight.w700,
//                 fontSize: 18,
//               ),
//               textAlign: TextAlign.start,
//             ),
//             TextFormField(
//               keyboardType: TextInputType.number,
//               decoration: InputDecoration(
//                 isDense: true,
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(6),
//                 ),
//                 focusedBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(6),
//                 ),
//               ),
//             ),
//             SizedBox(height: 10),
//             Text(
//               "Multiplier",
//               style: TextStyle(
//                 fontWeight: FontWeight.w700,
//                 fontSize: 18,
//               ),
//               textAlign: TextAlign.start,
//             ),
//             TextFormField(
//               keyboardType: TextInputType.number,
//               decoration: InputDecoration(
//                 isDense: true,
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(6),
//                 ),
//                 focusedBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(6),
//                 ),
//               ),
//             ),
//             SizedBox(height: 10),
//             SizedBox(
//               width: double.infinity,
//               child: ElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Color(0xff024a06),
//                   foregroundColor: Colors.white,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                 ),
//                 onPressed: () {},
//                 child: Text("Update"),
//               ),
//             ),
//           ],
//         ),
//       ],
//     ),
//   ),
// ),
// SizedBox(height: 10),
// Card(
//   elevation: 2,
//   color: Colors.grey.shade100,
//   child: Padding(
//     padding: const EdgeInsets.all(8.0),
//     child: ExpansionTile(
//       key: UniqueKey(),
//       initiallyExpanded: expendedTileIndex == 3,
//       onExpansionChanged: (expanded) {
//         setState(() {
//           expendedTileIndex = expanded ? 3 : null;
//         });
//       },
//       collapsedShape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(16),
//       ),
//       shape: RoundedRectangleBorder(side: BorderSide.none),
//       iconColor: Colors.grey.shade600,
//       title: Text(
//         "Current(R)",
//         style: TextStyle(
//           fontSize: 18,
//           color: Colors.blue,
//           fontWeight: FontWeight.bold,
//         ),
//       ),
//       leading: Icon(Icons.power, color: Colors.grey.shade600),
//       children: [
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Text(
//               "Status",
//               style: TextStyle(
//                 fontWeight: FontWeight.w700,
//                 fontSize: 18,
//               ),
//             ),
//             Switch(
//               activeColor: Color(0xff024a06),
//               value: controller.power.value,
//               onChanged: (value) {},
//             ),
//           ],
//         ),
//         Divider(height: 4),
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             SizedBox(height: 10),
//             Text(
//               "Minimum",
//               style: TextStyle(
//                 fontWeight: FontWeight.w700,
//                 fontSize: 18,
//               ),
//               textAlign: TextAlign.start,
//             ),
//             TextFormField(
//               keyboardType: TextInputType.number,
//               decoration: InputDecoration(
//                 isDense: true,
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(6),
//                 ),
//                 focusedBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(6),
//                 ),
//               ),
//             ),
//             SizedBox(height: 10),
//             Text(
//               "Maximum",
//               style: TextStyle(
//                 fontWeight: FontWeight.w700,
//                 fontSize: 18,
//               ),
//               textAlign: TextAlign.start,
//             ),
//             TextFormField(
//               keyboardType: TextInputType.number,
//               decoration: InputDecoration(
//                 isDense: true,
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(6),
//                 ),
//                 focusedBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(6),
//                 ),
//               ),
//             ),
//             SizedBox(height: 10),
//             Text(
//               "Multiplier",
//               style: TextStyle(
//                 fontWeight: FontWeight.w700,
//                 fontSize: 18,
//               ),
//               textAlign: TextAlign.start,
//             ),
//             TextFormField(
//               keyboardType: TextInputType.number,
//               decoration: InputDecoration(
//                 isDense: true,
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(6),
//                 ),
//                 focusedBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(6),
//                 ),
//               ),
//             ),
//             SizedBox(height: 10),
//             SizedBox(
//               width: double.infinity,
//               child: ElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Color(0xff024a06),
//                   foregroundColor: Colors.white,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                 ),
//                 onPressed: () {},
//                 child: Text("Update"),
//               ),
//             ),
//           ],
//         ),
//       ],
//     ),
//   ),
// ),
// SizedBox(height: 10),
// Card(
//   elevation: 2,
//   color: Colors.grey.shade100,
//   child: Padding(
//     padding: const EdgeInsets.all(8.0),
//     child: ExpansionTile(
//       key: UniqueKey(),
//       initiallyExpanded: expendedTileIndex == 4,
//       onExpansionChanged: (expanded) {
//         setState(() {
//           expendedTileIndex = expanded ? 4 : null;
//         });
//       },
//       collapsedShape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(16),
//       ),
//       shape: RoundedRectangleBorder(side: BorderSide.none),
//       iconColor: Colors.grey.shade600,
//       title: Text(
//         "Current(Y)",
//         style: TextStyle(
//           fontSize: 18,
//           color: Colors.blue,
//           fontWeight: FontWeight.bold,
//         ),
//       ),
//       leading: Icon(Icons.power, color: Colors.grey.shade600),
//       children: [
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Text(
//               "Status",
//               style: TextStyle(
//                 fontWeight: FontWeight.w700,
//                 fontSize: 18,
//               ),
//             ),
//             Switch(
//               activeColor: Color(0xff024a06),
//               value: controller.power.value,
//               onChanged: (value) {},
//             ),
//           ],
//         ),
//         Divider(height: 4),
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             SizedBox(height: 10),
//             Text(
//               "Minimum",
//               style: TextStyle(
//                 fontWeight: FontWeight.w700,
//                 fontSize: 18,
//               ),
//               textAlign: TextAlign.start,
//             ),
//             TextFormField(
//               keyboardType: TextInputType.number,
//               decoration: InputDecoration(
//                 isDense: true,
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(6),
//                 ),
//                 focusedBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(6),
//                 ),
//               ),
//             ),
//             SizedBox(height: 10),
//             Text(
//               "Maximum",
//               style: TextStyle(
//                 fontWeight: FontWeight.w700,
//                 fontSize: 18,
//               ),
//               textAlign: TextAlign.start,
//             ),
//             TextFormField(
//               keyboardType: TextInputType.number,
//               decoration: InputDecoration(
//                 isDense: true,
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(6),
//                 ),
//                 focusedBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(6),
//                 ),
//               ),
//             ),
//             SizedBox(height: 10),
//             Text(
//               "Multiplier",
//               style: TextStyle(
//                 fontWeight: FontWeight.w700,
//                 fontSize: 18,
//               ),
//               textAlign: TextAlign.start,
//             ),
//             TextFormField(
//               keyboardType: TextInputType.number,
//               decoration: InputDecoration(
//                 isDense: true,
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(6),
//                 ),
//                 focusedBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(6),
//                 ),
//               ),
//             ),
//             SizedBox(height: 10),
//             SizedBox(
//               width: double.infinity,
//               child: ElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Color(0xff024a06),
//                   foregroundColor: Colors.white,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                 ),
//                 onPressed: () {},
//                 child: Text("Update"),
//               ),
//             ),
//           ],
//         ),
//       ],
//     ),
//   ),
// ),
// SizedBox(height: 10),
// Card(
//   elevation: 2,
//   color: Colors.grey.shade100,
//   child: Padding(
//     padding: const EdgeInsets.all(8.0),
//     child: ExpansionTile(
//       key: UniqueKey(),
//       initiallyExpanded: expendedTileIndex == 5,
//       onExpansionChanged: (expanded) {
//         setState(() {
//           expendedTileIndex = expanded ? 5 : null;
//         });
//       },
//       collapsedShape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(16),
//       ),
//       shape: RoundedRectangleBorder(side: BorderSide.none),
//       iconColor: Colors.grey.shade600,
//       title: Text(
//         "Current(B)",
//         style: TextStyle(
//           fontSize: 18,
//           color: Colors.blue,
//           fontWeight: FontWeight.bold,
//         ),
//       ),
//       leading: Icon(Icons.power, color: Colors.grey.shade600),
//       children: [
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Text(
//               "Status",
//               style: TextStyle(
//                 fontWeight: FontWeight.w700,
//                 fontSize: 18,
//               ),
//             ),
//             Switch(
//               activeColor: Color(0xff024a06),
//               value: controller.power.value,
//               onChanged: (value) {},
//             ),
//           ],
//         ),
//         Divider(height: 4),
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             SizedBox(height: 10),
//             Text(
//               "Minimum",
//               style: TextStyle(
//                 fontWeight: FontWeight.w700,
//                 fontSize: 18,
//               ),
//               textAlign: TextAlign.start,
//             ),
//             TextFormField(
//               keyboardType: TextInputType.number,
//               decoration: InputDecoration(
//                 isDense: true,
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(6),
//                 ),
//                 focusedBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(6),
//                 ),
//               ),
//             ),
//             SizedBox(height: 10),
//             Text(
//               "Maximum",
//               style: TextStyle(
//                 fontWeight: FontWeight.w700,
//                 fontSize: 18,
//               ),
//               textAlign: TextAlign.start,
//             ),
//             TextFormField(
//               keyboardType: TextInputType.number,
//               decoration: InputDecoration(
//                 isDense: true,
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(6),
//                 ),
//                 focusedBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(6),
//                 ),
//               ),
//             ),
//             SizedBox(height: 10),
//             Text(
//               "Multiplier",
//               style: TextStyle(
//                 fontWeight: FontWeight.w700,
//                 fontSize: 18,
//               ),
//               textAlign: TextAlign.start,
//             ),
//             TextFormField(
//               keyboardType: TextInputType.number,
//               decoration: InputDecoration(
//                 isDense: true,
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(6),
//                 ),
//                 focusedBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(6),
//                 ),
//               ),
//             ),
//             SizedBox(height: 10),
//             SizedBox(
//               width: double.infinity,
//               child: ElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Color(0xff024a06),
//                   foregroundColor: Colors.white,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                 ),
//                 onPressed: () {},
//                 child: Text("Update"),
//               ),
//             ),
//           ],
//         ),
//       ],
//     ),
//   ),
// ),