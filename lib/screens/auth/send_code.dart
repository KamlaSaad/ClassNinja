import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import '../../controllers/resetPass_controller.dart';
import '../../widgets/shared.dart';
import 'share_contrl.dart';
class SendCode extends StatefulWidget {
  const SendCode({Key? key}) : super(key: key);

  @override
  State<SendCode> createState() => _SendCodeState();
}

class _SendCodeState extends State<SendCode> {
  bool sign=Get.arguments[0]=="sign";
  PassController passController=Get.put(PassController());
  double w=width*0.95;
  var val1=TextEditingController(),
      val2=TextEditingController(),
      val3=TextEditingController(),
      val4=TextEditingController(),
      val5=TextEditingController(),
      val6=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Directionality(textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(elevation: 0,backgroundColor: Colors.white,
            leading: BackButton(color: Colors.black,onPressed: ()=>Get.offNamed("/splash2"),),
            centerTitle: true,
            title: Txt(sign?"تفعيل الحساب" :"استرداد كلمة المرور", mainColor, 22, FontWeight.bold)),
        body: SafeArea(
          child: Container(width: width,height: height,
            child: SingleChildScrollView(
              child: Column(mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 20),
                  Container(width: w,alignment: Alignment.centerRight,
                      padding: EdgeInsets.only(right: 5),child:
                      Txt(" برجاء ادخال الكود المرسل علي الايميل", mainColor, 16, FontWeight.w600)),
                  SizedBox(height: 15),
                  SizedBox(width: w,height: 70,child: Center(
                    child: ListView(
                      scrollDirection: Axis.horizontal,reverse: true,
                      children: [
                        CodeInput(val1),
                        CodeInput(val2),
                        CodeInput(val3),
                        CodeInput(val4),
                        CodeInput(val5),
                        CodeInput(val6),
                        // Input(TextInputType.number,"", val1, 54, 40,null,(val){}, (val){}),
                        // SizedBox(width: width*0.02),
                      ],
                    ),
                  ),),
                  SizedBox(height: 20),
                  Center(child: Btn(Obx(() => authController.loading.isTrue?
                  CircularProgressIndicator(color: Colors.white,):btnTxt("ارسال")),
                      Colors.white, mainColor, mainColor, width*0.95, ()async{
                    String code="";
                    print(sign);

                    code=val1.text+val2.text+val3.text+val4.text+val5.text+val6.text;
                    print(code);
                    if(code.length>=5) {
                      if(sign){
                        print(authController.email.text);
                        authController.code.value=code;
                        await authController.verifyEmail();
                      }
                      else{
                        // Get.toNamed("/pass");
                        passController.code.value=code;
                        await passController.verifyCode();
                      }
                      resetVals();
                    }
                  })),
                  SizedBox(height: 16),
                  TxtBtn("لم يتم ارسال الكود؟ اعادة الارسال", Colors.black,18, ()async{
                    resetVals();
                    String email="";
                    if(sign) {
                      email = authController.email2.value;
                    } else {
                      email = passController.email.text;
                    }
                    print(email);
                    bool sent=await passController.resendCode(email);
                    if(sent) Popup("تم ارسال الكود");
                    else Popup(" عفوا لم يتم ارسال الكود");
                  }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  resetVals(){
    setState(() {
      val1.clear();
      val2.clear();
      val3.clear();
      val4.clear();
      val5.clear();
      val6.clear();
    });
  }
  Widget CodeInput(var contrl){
    return Container(width:54 ,height: 40,margin: EdgeInsets.symmetric(horizontal:width*0.01),
      child: TextFormField(controller: contrl,keyboardType:TextInputType.number,
        style: TxtStyle(Colors.black, 16, FontWeight.w600),
        decoration: InputDecoration(
            fillColor: inputColor,filled: true,
            focusedBorder:FieldBorder,border:FieldBorder,enabledBorder: FieldBorder,
        ),maxLength: 1,
      ),
    );}
}
