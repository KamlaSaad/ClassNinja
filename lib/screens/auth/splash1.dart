import 'package:class_ninja/widgets/shared.dart';
import 'package:flutter/material.dart';
class Splash1 extends StatelessWidget {
  const Splash1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Container(width: width,height: height,
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage("imgs/splash.png"),fit:BoxFit.fill)

      ),
      child: Column(
        children: [
          SizedBox(height: height*0.12,),
          SizedBox(width: 200,height: 200,child: Image.asset("imgs/logo.png"))
        ],
      ),

    ));
  }
}
