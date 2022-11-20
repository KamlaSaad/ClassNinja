import 'package:class_ninja/widgets/main_box.dart';
import 'package:class_ninja/widgets/shared.dart';
import 'package:flutter/material.dart';
class Favourite extends StatelessWidget {
  const Favourite({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(width: width,height: height,
        child: Column(
          children: [
            SizedBox(height: 10),
            Center(child: Txt("المفضلة", mainColor, 30, FontWeight.bold)),
            SizedBox(height: 10),
            // Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //   children: [
            //     MainBox("", true, "1500.00","ا.د/يوسف علي", "(للكشف)", "الرياض السعودية"),
            //     MainBox("", false, "1500.00","نظارة جوتشي", "", "الرياض السعودية"),
            //   ],
            // ),
            SizedBox(height: height*0.75,
              child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      mainAxisSpacing: 0,crossAxisSpacing: 5,childAspectRatio: 0.7,
                      crossAxisCount: 2),
                  itemCount: 7,
                  itemBuilder: (context,i){
                    return MainBox(width*0.46,"", true, "1500.00","ا.د/يوسف علي", "(للكشف)", "الرياض السعودية");}

              ),
            )
            // SizedBox(height: height*0.8,
            //   child: GridView.builder(
            //       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            //           // mainAxisSpacing: 12,
            //           crossAxisCount: 2),
            //       itemCount: 7,
            //       itemBuilder: (context,i){
            //         return MainBox("", true, "1500.00","ا.د/يوسف علي", "(للكشف)", "الرياض السعودية");
            //       }),
            // )
          ],
        ),
      ),
    );
  }
}
