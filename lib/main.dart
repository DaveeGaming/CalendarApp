import 'package:flutter/material.dart';
import 'package:idklolisthisbetter/AddEvent.dart';
import 'package:idklolisthisbetter/HomePage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:idklolisthisbetter/ObjectBox.dart';
import 'ColorScheme.dart';

late ObjectBox objectBox;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  objectBox = await ObjectBox.create();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // rgb(173, 136, 233)
        colorScheme: colors(),
        useMaterial3: true,
        textTheme: GoogleFonts.bellotaTextTextTheme(),
      ),
      routes: {
        '/bb': (context) => Home(),
        '/': (context) => AddEvent()
      },
    );
  }
}


