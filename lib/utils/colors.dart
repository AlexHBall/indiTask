import 'dart:ui';

enum Colour {
  blue,
  white,
  green,
  lightBlue,
  orange,
}

extension ColourExtension on Colour {
  static const colors = {
    Colour.blue: Color(0xFF1C2638),
    Colour.white: Color(0xFFFFF),
    Colour.green: Color(0xFF108B00),
    Colour.lightBlue: Color(0xFF9BBFD6),
    Colour.orange: Color(0xFFFF8C00),
  };

  Color get color => colors[this];
}
