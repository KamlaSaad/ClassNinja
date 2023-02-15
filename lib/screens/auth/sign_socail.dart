
import '../../widgets/bottom_bar.dart';
import '../../widgets/shared.dart';
import 'share_contrl.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
    // authController.resetSoicals();
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
                  // msg.isNotEmpty?SingleChildScrollView(
                  //   scrollDirection: Axis.horizontal,
                  //   child: Txt(msg, Colors.red, 16, FontWeight.normal),
                  // ):SizedBox(height: 0),
                  SizedBox(height: 10),
                  Center(child:  Btn(Obx(() => authController.loading.isTrue?
                  CircularProgressIndicator(color: Colors.white):
                  btnTxt("التالي")) ,Colors.white, mainColor, mainColor, width*0.95, ()async{
                    setState(() => msg="");
                    List sites=[authController.site,authController.snap,authController.twitter,
                      authController.instgram,authController.face];
                    for(int i=0;i<sites.length;i++){
                      if(sites[i].text.toString().isNotEmpty){
                        bool valid=validateUrl(sites[i].text);
                        if(!valid){
                         setState(() => msg="err");
                          Popup(" يجب ان يحتوي الرابط ع مثل هذه الرموز : \n (https://site.com/)");
                        }
                      }
                    }
                    if(msg!="err"){
                      await authController.signUp();
                    } })),
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
}
