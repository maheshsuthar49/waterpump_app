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