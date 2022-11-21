import 'package:class_ninja/widgets/shared.dart';
import 'package:flutter/material.dart';

import '../../widgets/main_box.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: width,height: height,
        padding: EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(children: [
            SizedBox(height: 10),
            Center(child: Txt("الرئيسية", mainColor, 30, FontWeight.bold)),
            SizedBox(height: 15),
            Container(height: 180,width: width*0.9,
                decoration: BoxDecoration(color: Colors.white,
                    image: DecorationImage(image: AssetImage("imgs/images1.png"),fit:BoxFit.fill),
                    borderRadius: BorderRadius.circular(10) )),
            SizedBox(height: 10),
            SingleChildScrollView(scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Txt("محلات", Colors.black, 18, FontWeight.w500),
                  Txt("النظارات", Colors.black, 20, FontWeight.w700),
                  SizedBox(width: width*0.15),
                  Txt("مشاهدة الكل", mainColor, 15, FontWeight.w600),
                ],
              ),
            ),
            SingleChildScrollView(scrollDirection: Axis.horizontal,
              child:Row(
                // scrollDirection: Axis.horizontal,
                  children: [
                    Container(height: 60,width: 150,child: Image(image: AssetImage("imgs/img2.png"),fit: BoxFit.fill)),
                    Container(height: 60,width: 150,child: Image(image: AssetImage("imgs/img2.png"),fit: BoxFit.fill)),
                    Container(height: 60,width: 150,child: Image(image: AssetImage("imgs/img2.png"),fit: BoxFit.fill)),
                  ],
              ),
            ),
            SingleChildScrollView(scrollDirection: Axis.horizontal,
              child:Row(
                children: [
                  Txt("دكاترة ", Colors.black, 18, FontWeight.w500),
                  Txt("ومستشفيات", Colors.black, 19, FontWeight.w700),
                  SizedBox(width: width*0.15,),
                  Txt("مشاهدة الكل", mainColor, 15, FontWeight.w600),
                ],
              ),
            ),
            // SizedBox(height: 10),
            SizedBox(height: 16),
            SingleChildScrollView(scrollDirection: Axis.horizontal,
              child:Row(
                children: [
                  Container(height: 50,width: 150,child: Image(image: AssetImage("imgs/img1.png"),fit: BoxFit.fill)),
                  SizedBox(width: 15,),
                  Container(height: 50,width: 150,child: Image(image: AssetImage("imgs/images1.png"),fit: BoxFit.fill)),
                  SizedBox(width: 15,),
                  Container(height: 50,width: 150,child: Image(image: AssetImage("imgs/img1.png"),fit: BoxFit.fill)),
                ],
              ),
            ),
            SizedBox(height: 20),
            SingleChildScrollView(scrollDirection: Axis.horizontal,
              child:Row(
                children: [
                  Txt(" الاعلانات ", Colors.black, 18, FontWeight.w500),
                  Txt("المميزة", Colors.black, 19, FontWeight.bold),
                  SizedBox(width: width*0.15),
                  Txt("مشاهدة الكل", mainColor, 15, FontWeight.w600),
                ],
              ),
            ),
            SingleChildScrollView(scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  MainBox(width*0.40,"", true, "1500.00","ا.د/يوسف علي", "(للكشف)", "الرياض السعودية"),
                  MainBox(width*0.40,"", false, "1500.00","ا.د/يوسف علي", "(للكشف)", "الرياض السعودية"),
                ],),
            )
          ],),

        ),
      ),
    );
  }
}
