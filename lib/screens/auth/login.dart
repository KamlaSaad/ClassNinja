import 'package:flutter/material.dart';
import 'package:class_ninja/widgets/shared.dart';
import 'package:get/get.dart';
import '../../controllers/auth_controller.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
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
                  SizedBox(height: 10),
                  // Container(
                  //   // color: Colors.red,
                  //   width: width*0.7,alignment: Alignment.centerLeft,
                  //     child:
                  Row(mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                  Txt( "تسجيل الدخول", mainColor, 25, FontWeight.bold),
                    SizedBox(width: width*0.06),
                    GestureDetector(onTap: ()=>Get.toNamed("/app"),
                      child: underlineTxt( "تخطي الان ", Colors.black, 16, FontWeight.bold),
                    ),
                  ],),

                  SizedBox(height: height*0.05),
                  Center(child: Input("رقم الجوال", authController.phone, w,50,null, (val){}, (val){})),
                  SizedBox(height: 10),
                  Center(child: Input("كلمة المرور", authController.pass, w,50,null, (val){}, (val){})),
                 Container(
                   alignment: Alignment.topLeft,
                   child: TxtBtn("استرداد كلمة المرور", mainColor,18, ()=>Get.toNamed("/email")),
                 ),
                  SizedBox(height: 7),
                  Center(child: Btn("تسجيل الدخول",Colors.white, mainColor, mainColor, width*0.95, (){
                    print(authController.phone.text);
                    print(authController.pass.text);
                  })),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
