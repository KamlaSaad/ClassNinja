
import 'package:flutter/material.dart';
import '../../controllers/conn.dart';
import '../../controllers/location.dart';
import '../../widgets/bottom_bar.dart';
import 'share_contrl.dart';
import '../../widgets/shared.dart';
import 'package:get/get.dart';
import 'package:flutter_html/flutter_html.dart';
// import 'package:html/dom.dart' as dom;

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  IconData passIcon=Icons.visibility_off;
  LoCation loCation=LoCation();
  double w=width*0.95,nameH=56,emailH=56,phoneH=56,watsH=56,addressH=56,passH=56;
  int radioVal=0,groupVal=0;
  var formKey=GlobalKey<FormState>();
  Color btnColor=mainColor.withOpacity(0.6);
  String address="",addressMsg="";
  bool getLocation=false;
  @override
  void initState() {
    authController.resetVals();
    super.initState();
  }
  // final scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    //   if (scrollController.hasClients) {
    //     scrollController.jumpTo(scrollController.position.maxScrollExtent);
    //   }
    // });
    return Directionality(textDirection: TextDirection.rtl,
      child: Scaffold(resizeToAvoidBottomInset: true,
      appBar: MainBar("انشاء الحساب",25, false,true),
      body:
      // SingleChildScrollView(controller: scrollController,reverse: true,
      //   child:
        ListView(
          children: [
            Container(width: width,
                  child:  Form(key: formKey,
                      child: Column(mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          // SizedBox(height: 5),
                          SizedBox(height: 10),
                          Center(child: UserDropDown()),
                          SizedBox(height: 10),
                          Center(child: Input(TextInputType.text,"اسم المستخدم", authController.username, w, nameH,null,(val){
                            if (val.toString().length < 4) {
                              setState(() =>nameH=80);
                              return 'يجب الا يقل الاسم عن 4 احرف';
                            }setState(() =>nameH=56);
                          }, (val){})),
                          // SizedBox(height: 12),
                          SizedBox(height: 10),
                          Center(child: Input(TextInputType.emailAddress,"الايميل", authController.email, w,emailH,null, (val){
                            if (!RegExp(authController.validEmail).hasMatch(val)) {
                              setState(() =>emailH=80);
                              return 'برجاء ادخال ايميل صحيح';
                            }setState(() =>emailH=56);
                          }, (val){})),
                          SizedBox(height: 10),
                          Center(child: Input(TextInputType.phone,"رقم الجوال", authController.phone, w,phoneH,null, (val){
                            if (!RegExp(authController.validPhone).hasMatch(val)) {
                              setState(() =>phoneH=80);
                              return 'برجاء ادخال رقم صحيح';
                            }setState(() =>phoneH=56);
                          }, (val){})),
                          SizedBox(height: 10),
                          Center(child: Input(TextInputType.phone,"رقم الواتساب", authController.whatsapp, w,watsH,null, (val){
                            if (!RegExp(authController.validPhone).hasMatch(val)) {
                              setState(() =>watsH=80);
                              return 'برجاء ادخال رقم صحيح';
                            }setState(() =>watsH=56);
                          }, (val){})),
                          //==============address==========
                         Obx(() => authController.selectedUser.value=="provider"?Column(mainAxisSize: MainAxisSize.min,
                            children: [
                              // Spacer(),
                              SizedBox(height: 10),
                              Center(child: Obx(() =>InputFile(authController.address.value, inputColor, w,56,null, ()async{
                                var result;
                                if(!getLocation){result=await loCation.getLocation();}
                                List args=[false,loCation.latitude.value,loCation.longitude.value,authController.saveLoc];
                                bool online=await connection();
                                if(loCation.latitude.value==0.0 && online){
                                  Popup(" لتحديد موقعك علي الخريطة يرجي التاكد من تفعيل خصية تحديد موقع الجهاز");
                                }
                                if(!online) {Popup(" يرجي التاكد من الاتصال بالانترنت ");}
                                else{
                                  Get.toNamed("/map",arguments: args);
                                  setState(() {
                                    addressMsg="";
                                  });
                                }
                                if(result!='denied' &&result!=null){setState(() => getLocation=true);}
                                if(mapLat.value>0.0) {setState(()=> addressMsg = "");}
                              }))),
                              addressMsg.isNotEmpty?Container(alignment: Alignment.centerRight,
                                padding: EdgeInsets.only(right: 10,top: 5),
                                child: Txt( addressMsg, Colors.red, 14, FontWeight.w500),
                              ):SizedBox(height: 0,),
                            ],
                          ):SizedBox(height: 0)),
                          //==============address errMsg==========
                          SizedBox(height: 10),
                          //========activity type=================
                          Obx(() => authController.selectedUser.value=="provider"?Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: Center(child: activityDropDown()),
                          ):SizedBox(height: 0)),
                          // SizedBox(height: 12),
                          Center(child: Obx(() => InputFile(authController.img.value,inputColor, w, 56,Icons.file_upload_outlined,
                                  ()async=> await authController.uploadImg() ))),
                          SizedBox(height: 10),
                          Center(child: Input(TextInputType.text,"كلمة المرور", authController.pass, w,passH,
                              IconButton(onPressed: (){
                                setState(() =>showPass=!showPass);
                              }, icon: Icon(showPass?Icons.visibility_off:Icons.visibility,color: mainColor))
                              , (val){
                                if (val.toString().length < 8) {
                                  setState(() =>passH=80);
                                  return 'بجب الا تقل كلمة المرور عن 8 احرف';
                                }setState(() =>passH=56);
                              }, (val){})),
                          Container(
                            alignment: Alignment.topLeft,
                            child: Row(
                              children: [
                                Radio(value: 1, groupValue: groupVal, onChanged: (val)async{
                                    String terms=authController.terms.value,
                                        policy=authController.policy.value;
                                      if(terms.isEmpty &&policy.isEmpty){
                                        await authController.getTerms();
                                      }
                                      if(authController.online.isTrue) {
                                        TermsDialog();
                                      }else {
                                      Popup("يرجي التاكد من الاتصال بالانترنت");
                                      }
                                },activeColor: mainColor,),
                                Txt("اوافق علي شروط الاستخدام", mainColor,17, FontWeight.w500)
                              ],
                            ),
                          ),
                          SizedBox(height: 10),
                          Center(child:  Btn(btnTxt("التالي"),Colors.white,
                              groupVal==1?mainColor:btnColor, groupVal==1?mainColor:btnColor, width*0.95, ()async{
                            if(groupVal==1) {
                              print(authController.imgPath);
                              bool? valid = formKey.currentState?.validate();
                              if(valid == true) {
                                if( authController.address.value=="العنوان" && authController.selectedUser.value=="provider") {
                                  setState(() => addressMsg = "من فضلك ادخل عنوان");
                                } else Get.toNamed("/social");
                              }
                            }

                          })),
                          SizedBox(height: 10),
                        ],
                      ),
                    ),
                  ),
          ],
        ),
      // ),
          ),

    );}
  TermsDialog(){
    Get.defaultDialog(
      title: "شروط الاستخدام",
      titleStyle:
      TxtStyle(mainColor, 20, FontWeight.w600),
      contentPadding: EdgeInsets.only(bottom: 0, right: 10, left: 10, top: 5),
      content: Directionality(
        textDirection: TextDirection.rtl,
        child:Obx(() =>
                authController.loading.isTrue?
                CircularProgressIndicator(color: mainColor):
                (authController.terms.isEmpty?
                Txt("عفوا حدث خطا", Colors.black, 17,FontWeight.w500):
                Container(height: height*0.75,
                  child: SingleChildScrollView(
                    child:
                    Column(crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Txt("* ${authController.policy.value}", Colors.black, 17,
                      //     FontWeight.w500),
                      // SizedBox(height: 8),
                      // Txt("* ${authController.terms.value}", Colors.black, 17,
                      //     FontWeight.w500),
                      Html(
                      data: """
                       <div>
                       ${authController.policy.value}
                       <p>الخصوصية</p>
                       ${authController.terms.value}
                       </div>
                      """),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: TxtBtn("اوافق", mainColor, 18,
                                () {
                              setState(() => groupVal = 1);
                              Get.back();
                            }),
                      )
                    ],
                 ),
                  ),
                ))
        ),
      ),
    );
  }
}
