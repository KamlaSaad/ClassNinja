
import 'package:class_ninja/widgets/bottom_bar.dart';

import 'share_contrl.dart';
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
  String msg="";
  @override
  Widget build(BuildContext context) {
    return  Directionality(textDirection: TextDirection.rtl,
      child: Scaffold(appBar: MainBar("التواصل الاجتماعي",22,  false, true),
      body:SafeArea(
          child: Container(width: width,height: height,
            child: SingleChildScrollView(
              child: Column(mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(height: height*0.05),
                  Center(child: Input(TextInputType.text,"الموقع الالكتروني", authController.site, w,50,null, (val){
                  }, (val){ })),
                  SizedBox(height: 10),
                  Center(child: Input(TextInputType.text,"سناب شات", authController.snap, w,50,null, (val){}, (val){})),
                  SizedBox(height: 7),
                  Center(child: Input(TextInputType.text,"تيوتر", authController.twitter, w,50,null, (val){}, (val){})),
                  SizedBox(height: 10),
                  Center(child: Input(TextInputType.text,"انستجراب", authController.instgram, w,50,null, (val){}, (val){})),
                  SizedBox(height: 10),
                  Center(child: Input(TextInputType.text,"فيسبوك", authController.face, w,50,null, (val){}, (val){})),
                  msg.isNotEmpty?SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Txt(msg, Colors.red, 16, FontWeight.normal),
                  ):SizedBox(height: 0),
                  SizedBox(height: 10),
                  Center(child:  Btn(Obx(() => authController.loading.isTrue?
                  CircularProgressIndicator(color: Colors.white):
                  btnTxt("التالي")) ,Colors.white, mainColor, mainColor, width*0.95, ()async{
                    await authController.signUp();
                    // pathUrl();
                    // if(msg.isEmpty){
                    //   // await authController.signUp();
                    //   print("path");
                    // }

                    // var sent=await authController.sendCode();
                    // if(sent)
                    //     Get.offNamed("/code", arguments: ["sign"]);
                    // else errMsg("عفوا حدث خطا  ");
                            // authController.loading.value=false;
                      })),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  validateUrl(link){
    return Uri.tryParse(link)?.hasAbsolutePath ?? false;
  }


  pathUrl(String txt){
    if(txt.isNotEmpty) {
      if(!validateUrl(txt))
        setState(() =>msg="https://google.com/الرابط غير صجيج يرجي ادخال رابط مشابه لهذا ");
      else  setState(() =>msg="");
    }
    //"https://google.com/"
    // List sites=[authController.site,authController.snap,authController.twitter,
    //   authController.instgram,authController.face];
    // sites.forEach((i) {
    //   print(!validateUrl(i.text));
    //   if(i.text.isNotEmpty) {
    //     if(!validateUrl(i.text))
    //       setState(() =>msg=msg="https://google.com/الرابط غير صجيج يرجي ادخال رابط مشابه لهذا ");
    //     else  setState(() =>msg="");
    //   }
    // });

  }
}
