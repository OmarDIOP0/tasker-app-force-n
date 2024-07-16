import 'package:flutter/cupertino.dart';

class CustomAppBarClipper extends CustomClipper<Path>{
  @override
  Path getClip(Size size) {
    var path = Path();
    double w = size.width;
    double h =size.height;

      path.lineTo(0,h);
      path.quadraticBezierTo(w/4, h-40, w / 2, h - 20);
      path.quadraticBezierTo(3/4*w,h, w, h - 30);
      path.lineTo(w, 0);
      path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}