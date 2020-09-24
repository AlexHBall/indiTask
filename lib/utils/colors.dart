import 'dart:ui';

enum Colour {
  blue,
  white,
  green,
  lightBlue,
  orange,
  grey,
  darkPurple,
  backGrey,
}

extension ColourExtension on Colour {
  static const colors = {
    Colour.blue: Color(0xFF1C2638),
    Colour.white: Color(0xFFFFF),
    Colour.green: Color(0xFF108B00),
    Colour.lightBlue: Color(0xFF9BBFD6),
    Colour.orange: Color(0xFFFF8C00),
    Colour.grey : Color(0xFFE8E8E8),
    Colour.darkPurple : Color(0xFF272140),
    Colour.backGrey : Color(0xFFF2F7FB),
  };

  Color get color => colors[this];
}
