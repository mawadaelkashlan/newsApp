import 'dart:async';

import 'package:flutter/material.dart';
import 'package:news_app/layout/news_layout.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), ()  {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>NewsLayout()));
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.redAccent,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.menu_book, size: 80,color: Colors.grey[200],),
            SizedBox(height: 10,),
            Text("News ",style: TextStyle(
                color: Colors.grey[200],
                fontSize: 40,
                fontWeight: FontWeight.w500
            ),)
          ],
        ),
      ),
    );
  }
}
