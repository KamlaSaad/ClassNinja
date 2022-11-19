import 'package:flutter/material.dart';
import 'package:class_ninja/widgets/shared.dart';
import 'package:get/get.dart';
import '../../controllers/auth_controller.dart';

class NewPass extends StatefulWidget {
  const NewPass({Key? key}) : super(key: key);

  @override
  State<NewPass> createState() => _NewPassState();
}

class _NewPassState extends State<NewPass> {
  AuthController authController=Get.put(AuthController());
  double w=width*0.95;
  var formKey=GlobalKey<FormState>();
  String error="";
  @override
  Widget build(BuildContext context) {
    return Directionality(textDirection: TextDirection.rtl,
      child: Scaffold(
      appBar: AppBar(elevation: 0,backgroundColor: Colors.white,
          leading: BackButton(color: Colors.black),
          centerTitle: true,
          title: Txt( "استرداد كلمة المرور", mainColor, 22, FontWeight.bold)),
      body: SafeArea(
          child: Container(width: width,height: height,
            child: SingleChildScrollView(
              child: Form(key: formKey,
                child: Column(mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20),
                    Padding(padding: EdgeInsets.only(right: width*0.05),child:
                    Txt("برجاء ادخال كلمة المرور الجديدة", mainColor, 18, FontWeight.w600)),
                    SizedBox(height: 15),
                    Center(child: Input("كلمة المرور", authController.pass, w,50,null, (val){}, (val){})),
                    SizedBox(height: 15),
                    Center(child: Input("تاكيد كلمة المرور", authController.pass2, w,50, null,(val){}, (val){})),
                    errMsg(error),
                    SizedBox(height: 15),
                    Center(child: Btn("ارسال",Colors.white, mainColor, mainColor, width*0.95, (){
                      String pass1=authController.pass.text.trim(),
                          pass2=authController.pass2.text.trim();
                        if(pass1.isNotEmpty &&pass2.isNotEmpty){
                          if(pass1.length<6) setState(() =>error='بجب الا تقل كلمة المرور عن 6 احرف');
                          else if(pass2!=pass1)  setState(() =>error='كلمة المرور غير متطابقة');
                          else{
                            setState(() =>error='');
                          }
                        }
                    })),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
