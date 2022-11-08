import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meruem/app_styles.dart';
import 'package:meruem/views/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './views/pages.dart';

bool? seenOnboard;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // to show status bar
  SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual, overlays: [SystemUiOverlay.bottom, SystemUiOverlay.top]);
  SharedPreferences pref = await SharedPreferences.getInstance();
  seenOnboard = pref.getBool('seenOnboard') ?? false; //if null set to false

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Meruem',
      theme: ThemeData(
        textTheme: GoogleFonts.manropeTextTheme(
          Theme.of(context).textTheme,
        ),
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: kScaffoldBackground,
      ),
      initialRoute: '/',
      home: seenOnboard == true ? HomeScreen(key: UniqueKey()) : OnBoardingPage(),
      routes: routes,
    );
  }
}
