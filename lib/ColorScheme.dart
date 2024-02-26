import 'package:flutter/material.dart';



ColorScheme colors() {
  var Colorscheme = ColorScheme(
    brightness: Brightness.dark,
    primary: Color.fromARGB(255, 173, 136, 233),
    secondary: Colors.blueGrey,
    background: Color.fromARGB(255, 60, 49, 78),


    surface: Color.fromARGB(255, 173, 136, 233),
    error: Colors.cyan,

    onPrimary: Colors.white,
    onSecondary: Colors.blue,
    onSurface: Colors.black,
    onBackground: Colors.green,
    onError: Colors.deepOrange,
  );
  return Colorscheme;
}