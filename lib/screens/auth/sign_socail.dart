
import 'package:class_ninja/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_ninja/widgets/shared.dart';
class SignSocial extends StatefulWidget {
  const SignSocial({Key? key}) : super(key: key);

  @override
  State<SignSocial> createState() => _SignSocialState();
}

class _SignSocialState extends State<SignSocial> {
  double w=width*0.95;
  AuthController authController=Get.put(AuthController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Directionality(textDirection: TextDirection.rtl,
        child: SafeArea(
          child: Container(width: width,height: height,
            child: SingleChildScrollView(
              child: Column(mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(height: 5),
                  Row(mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                      Txt("التواصل الاجتماعي", mainColor, 21, FontWeight.bold),
                      SizedBox(width: width*0.05),
                      TxtBtn("تخطي الان ", Colors.black,15, (){}),
                    ],),
                  SizedBox(height: height*0.05),
                  Center(child: Input("الموقع الالكتروني", authController.site, w,50,null, (val){}, (val){})),
                  SizedBox(height: 10),
                  Center(child: Input("سناب شات", authController.snap, w,50,null, (val){}, (val){})),
                  SizedBox(height: 7),
                  Center(child: Input("تيوتر", authController.twitter, w,50,null, (val){}, (val){})),
                  SizedBox(height: 10),
                  Center(child: Input("انستجراب", authController.instgram, w,50,null, (val){}, (val){})),
                  SizedBox(height: 10),
                  Center(child: Input("فيسبوك", authController.face, w,50,null, (val){}, (val){})),
                  SizedBox(height: 10),
                  Center(child: Obx(() => Btn(authController.loading.isFalse?
                       "التالي":CircularProgressIndicator(color: Colors.white)
                      ,Colors.white, mainColor, mainColor, width*0.95, (){
                    Get.offNamed("/app");
                        // authController.loading.value=false;
                      }))),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
