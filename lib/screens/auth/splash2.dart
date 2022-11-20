import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_ninja/widgets/shared.dart';
class Splash2 extends StatelessWidget {
  const Splash2({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(elevation: 0,backgroundColor: Colors.white,
          title: Txt( "تخطي الان ", Colors.black, 16, FontWeight.bold)),
      body: Container(width: width,height: height,
        child: Column(mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: height*0.12),
            CircleAvatar(radius: 60,backgroundColor: Colors.black,),
            SizedBox(height: 6),
            Txt( "ClassNinja", Colors.black, 28, FontWeight.bold),
            SizedBox(height: height*0.14),
            Btn("تسجيل الدخول", mainColor, Colors.white, mainColor, width*0.95, ()=>Get.toNamed("/login")),
            SizedBox(height: 18),
            Btn("انشاء حساب",  Colors.white,mainColor, mainColor, width*0.95, ()=>Get.toNamed("/signup")),
          ],
        ),
      ),

    );
  }
}
