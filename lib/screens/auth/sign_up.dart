import 'package:flutter/material.dart';
import '../../controllers/auth_controller.dart';
import '../../widgets/shared.dart';
import 'package:get/get.dart';
class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  double w=width*0.95;
  AuthController authController=Get.put(AuthController());
  int radioVal=0,groupVal=0;
  var formKey=GlobalKey<FormState>();
  String error="";
  double nameH=50,emailH=50,phoneH=50,addressH=50,passH=50;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Directionality(textDirection: TextDirection.rtl,
        child: SafeArea(
          child: Container(width: width,height: height,
            child: SingleChildScrollView(
              child: Form(key: formKey,
                child: Column(mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    SizedBox(height: 5),
                    Container(
                      // color: Colors.red,
                      width: width*0.7,
                      // alignment: Alignment.centerLeft,
                      child: Row(mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                        Txt( "انشاء الحساب", mainColor, 25, FontWeight.bold),
                        SizedBox(width: width*0.1),
                        TxtBtn("تخطي الان ", Colors.black,15, (){}),
                      ],),
                    ),
                    SizedBox(height: height*0.05),
                    Center(child: Input("اسم المستخدم", authController.username, w, nameH,null,(val){
                      if (val.toString().length < 4) {
                        setState(() =>nameH=80);
                        return 'يجب الا يقل الاسم عن 4 احرف';
                      }setState(() =>nameH=50);
                    }, (val){})),
                    SizedBox(height: 12),
                    Center(child: Input("الايميل", authController.email, w,emailH,null, (val){
                      if (!RegExp(authController.validEmail).hasMatch(val)) {
                        setState(() =>emailH=80);
                        return 'برجاء ادحال ايميل صحيح';
                      }setState(() =>emailH=50);
                    }, (val){})),
                    SizedBox(height: 12),
                    Center(child: Input("رقم الجوال", authController.phone, w,phoneH,null, (val){
                      if (!RegExp(authController.validPhone).hasMatch(val)) {
                        setState(() =>phoneH=80);
                        return 'برجاء ادحال رقم صحيح';
                      }setState(() =>phoneH=50);
                    }, (val){})),
                    SizedBox(height: 12),
                    Center(child: Input("رقم الواتساب", authController.whatsapp, w,50,null, (val){}, (val){})),
                    SizedBox(height: 10),
                    Center(child: Input("العنوان", authController.address, w,addressH,null, (val){
                      if (val.toString().length <= 2) {
                        setState(() =>addressH=80);
                        return 'برجاء ادحال عنوان صحيح';
                      }setState(() =>addressH=50);
                    }, (val){})),
                    SizedBox(height: 12),
                    Center(child: DropDown()),
                    SizedBox(height: 12),
                    Center(child: Input("الشعار", authController.img, w,50,IconButton(onPressed: (){},
                        icon: Icon(Icons.file_upload_outlined,color: mainColor)), (val){}, (val){})),
                    SizedBox(height: 12),
                    Center(child: Input("كلمة المرور", authController.pass, w,passH,null, (val){
                      if (val.toString().length < 6) {
                        setState(() =>passH=80);
                        return 'بجب الا تقل كلمة المرور عن 6 احرف';
                      }setState(() =>passH=50);
                    }, (val){})),
                    Container(
                      alignment: Alignment.topLeft,
                      child: Row(
                        children: [
                          Radio(value: 1, groupValue: groupVal, onChanged: (val){
                            setState(() {
                              groupVal=val!;
                            });
                          },activeColor: mainColor,),
                          Txt("اوافق علي شروط الاستخدام", mainColor,17, FontWeight.w500)
                        ],
                      ),
                    ),
                    SizedBox(height: 8),
                    Center(child: Btn("التالي",Colors.white, mainColor, mainColor, width*0.95, (){
                      if(groupVal==1) {
                        bool? valid = formKey.currentState?.validate();
                        // print(formKey.currentState?.validate());
                        if(valid==true)
                          Get.toNamed("/social");
                      }
                    })),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );}
}
