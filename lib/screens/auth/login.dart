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
      // appBar: AppBar(elevation: 0,backgroundColor: Colors.white,
      //     leading: Container(width: 100,
      //       padding: const EdgeInsets.all(5),
      //       child: TxtBtn("تخطي الان ", Colors.black,15, (){}),
      //     ),
      //     centerTitle: true,
      //     title: Txt( "تسجيل دخول", mainColor, 22, FontWeight.bold)),
      body: Directionality(textDirection: TextDirection.rtl,
        child: SafeArea(
          child: Container(width: width,height: height,
            child: SingleChildScrollView(
              child: Column(mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(height: 10),
                  Container(
                    // color: Colors.red,
                    width: width*0.7,alignment: Alignment.centerLeft,
                      child: Row(children: [
                      Txt( "تسجيل الدخول", mainColor, 25, FontWeight.bold),
                        SizedBox(width: width*0.06),
                        TxtBtn("تخطي الان ", Colors.black,15, (){}),
                      ],),
                    ),
                  SizedBox(height: height*0.05),
                  Center(child: Input("رقم الجوال", authController.phone, w,50,null, (val){}, (val){})),
                  SizedBox(height: 10),
                  Center(child: Input("كلمة المرور", authController.pass, w,50,null, (val){}, (val){})),
                 Container(
                   alignment: Alignment.topLeft,
                   child: TxtBtn("استرداد كلمة المرور", mainColor,20, ()=>Get.toNamed("/email")),
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
