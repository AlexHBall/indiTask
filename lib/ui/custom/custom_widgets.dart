import 'package:flutter/material.dart';

Container containerButtonText(double w, double h, String text, Color backgroundColor) {
  return Container(
      width: w,
      height: h,
      decoration: BoxDecoration(
        border: Border.all(width: 1.0, color: Color(0xFF1C2638)),
        borderRadius: BorderRadius.circular(50),
        color: backgroundColor,
      ),
      child: Padding(
        padding: const EdgeInsets.all(22.0),
        child: Text(text,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color:
                    // Color(0xFF1C2638)
                    Colors.purple)),
      ));
}

Container containerButtonTextNoSolidBorder(double w, double h, String text, Color backgroundColor) {
  return Container(
      width: w,
      height: h,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
        color: backgroundColor,
      ),
      child: Padding(
        padding: const EdgeInsets.all(22.0),
        child: Text(text,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color:
                    // Color(0xFF1C2638)
                    Colors.purple)),
      ));
}

Container containerButtonIcon(double w, double h) {
  return Container(
      width: w,
      height: h,
      decoration: BoxDecoration(
        border: Border.all(width: 1.0, color: Color(0xFF9BBFD6)),
        borderRadius: BorderRadius.circular(50),
        color: Color(0xFFFF),
      ),
      child: Padding(
          padding: const EdgeInsets.all(22.0), child: Icon(Icons.alarm)));
}
