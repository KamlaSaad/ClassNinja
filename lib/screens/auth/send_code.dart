import 'package:flutter/material.dart';
import 'package:class_ninja/widgets/shared.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
class SendCode extends StatefulWidget {
  const SendCode({Key? key}) : super(key: key);

  @override
  State<SendCode> createState() => _SendCodeState();
}

class _SendCodeState extends State<SendCode> {
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
          leading: BackButton(color: Colors.black),
          centerTitle: true,
          title: Txt( "استرداد كلمة المرور", mainColor, 22, FontWeight.bold)),
      body: SafeArea(
          child: Container(width: width,height: height,
            child: SingleChildScrollView(
              child: Column(mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 20),
                  Container(width: w,alignment: Alignment.centerRight,
                      padding: EdgeInsets.only(right: 5),child:
                  Txt("برجاء ادخال الكود المرسل", mainColor, 18, FontWeight.w600)),
                  SizedBox(height: 15),
                  SizedBox(width: w,height: 70,child: Center(
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        Input("", val1, 54, 40,null,(val){}, (val){}),
                        SizedBox(width: 4),
                        Input("", val2, 54,40, null,(val){}, (val){}),
                        SizedBox(width: 4),
                        Input("", val3, 54, 40,null,(val){}, (val){}),
                        SizedBox(width: 4),
                        Input("", val4, 54,40, null,(val){}, (val){}),
                        SizedBox(width: 4),
                        Input("", val5, 54, 40,null,(val){}, (val){}),
                        SizedBox(width: 4),
                        Input("", val6, 54,40, null,(val){}, (val){}),
                      ],
                    ),
                  ),),
                  SizedBox(height: 15),
                  Center(child: Btn("ارسال",Colors.white, mainColor, mainColor, width*0.95, (){
                    String code="";
                    code=val6.text+val5.text+val4.text+val3.text+val2.text+val1.text;
                    print(code);
                    if(code.length==6)
                      Get.toNamed("/pass");
                  })),
                  SizedBox(height: 16),
                  TxtBtn("لم يتم ارسال الكود؟ اعادة الارسال", Colors.black,18, (){}),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
