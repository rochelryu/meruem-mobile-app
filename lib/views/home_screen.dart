import 'package:flutter/material.dart';
import 'package:meruem/app_styles.dart';

class HomeScreen extends StatefulWidget {
  static String rootName = '/homeScreen';
  const HomeScreen({required Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        leading: Stack(
          children: [
            Container(
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: kSecondaryColor,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 10.0,
                        offset: Offset(3.0, 6.0),
                        color: Colors.black12)
                  ]
              ),
              child: Center(child: Icon(Icons.person_outline_rounded, color: Colors.white, size: 15,)),
            ),
            Positioned(
                top: 10,
                right: 10,
                child: Container(
                  height: 10,
                  width: 10,
                  decoration: BoxDecoration(
                    color: kPrimaryColor,
                    borderRadius: BorderRadius.circular(5),
                  ),
                )
            )
          ],
        ),
        title: Column(
          children: [

          ],
        ),
      ),
      body: Container(),
    );
  }
}
