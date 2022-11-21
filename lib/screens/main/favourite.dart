import 'package:class_ninja/widgets/main_box.dart';
import 'package:class_ninja/widgets/shared.dart';
import 'package:flutter/material.dart';
class Favourite extends StatelessWidget {
  const Favourite({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(width: width,height: height,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 10),
              Center(child: Txt("المفضلة", mainColor, 30, FontWeight.bold)),
              SizedBox(height: 10),
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  MainBox(width*0.42,"", true, "1500.00","ا.د/يوسف علي", "(للكشف)", "الرياض السعودية"),
                  MainBox(width*0.42,"", false, "1500.00","نظارة جوتشي", "", "الرياض السعودية"),
                ],
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  MainBox(width*0.42,"", true, "1500.00","ا.د/يوسف علي", "(للكشف)", "الرياض السعودية"),
                  MainBox(width*0.42,"", false, "1500.00","نظارة جوتشي", "", "الرياض السعودية"),
                ],
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  MainBox(width*0.42,"", true, "1500.00","ا.د/يوسف علي", "(للكشف)", "الرياض السعودية"),
                  MainBox(width*0.42,"", false, "1500.00","نظارة جوتشي", "", "الرياض السعودية"),
                ],
              ),
              Row(mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  MainBox(width*0.42,"", true, "1500.00","ا.د/يوسف علي", "(للكشف)", "الرياض السعودية"),
                ],
              ),
              // SizedBox(height: height*0.75,
              //   child: GridView.builder(
              //       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              //           mainAxisSpacing: 0,crossAxisSpacing: 5,childAspectRatio: 0.66,
              //           crossAxisCount: 2),
              //       itemCount: 7,
              //       itemBuilder: (context,i){
              //         return MainBox(width*0.46,"", true, "1500.00","ا.د/يوسف علي", "(للكشف)", "الرياض السعودية");}
              //
              //   ),
              // )
            ],
          ),
        ),
      ),
    );
  }
}
