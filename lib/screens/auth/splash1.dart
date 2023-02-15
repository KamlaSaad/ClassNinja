
import 'package:flutter/material.dart';

import '../../widgets/shared.dart';
class Splash1 extends StatelessWidget {
  const Splash1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(width: width,height: height,
        decoration: BoxDecoration(color: inputColor,
            image: DecorationImage(image: AssetImage("imgs/splash.png"),fit:BoxFit.fill)
        ),
        child: Column(
          children: [
            SizedBox(height: height*0.35),
            SizedBox(width: 200,height: 200,child: Image.asset("imgs/logo1.png"))
          ],
        ),

      ),
    );
  }
}
