
import 'package:E3yoon/controllers/get_token.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../../controllers/conn.dart';
import '../../controllers/user_controller.dart';
import '../../widgets/shared.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  UserController userController=Get.put(UserController());
  late File imgPath=File("");
  var msg="".obs,
      changeImg=false.obs,
      change=false.obs,
      name="".obs,
      phone="".obs,
      email="".obs,
      wats="".obs,
      address="".obs,
      site="".obs,
      face="".obs,
      twitter="".obs,
      snap="".obs,
      insta="".obs,
      pass="".obs;
  String img="";
  double w=width*0.9;
  @override
  Widget build(BuildContext context) {
    initAllSites();
    userController.updateContrls();
    img=userController.img.value;
    return Directionality(textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar:  AppBar(elevation: 0,backgroundColor: Colors.white,
          leading: BackButton(color: Colors.black,),
          title: Txt("تعديل البيانات", mainColor, 24, FontWeight.bold),
        ),
        body: Container(width: width,height: height,
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  SizedBox(height: 10),
                  //img
                  Stack(
                    children: [
                     ImgBox(),
                      Positioned(bottom: 0,left: 0,
                          child: CircleAvatar(radius: 20,backgroundColor: mainColor,
                            child: IconButton(icon: Icon(Icons.camera_alt),onPressed: ()=>uploadImg()),
                          )),
                    ],
                  ),
                  SizedBox(height: 20),
                  Box("اسم المستخدم",userController.name,name, w, userController.nameContrl,false,(){
                    String newVal=userController.nameContrl.text.trim();
                    if(newVal!=userController.name.value.trim()){
                      if (userController.nameContrl.text.trim().length < 4) {
                        msg.value = 'يجب الا يقل الاسم عن 4 احرف';
                      } else {
                        name.value=newVal;
                        change.value=true;
                        msg.value='';
                        Get.back();
                      }
                    } else {
                      userController.nameContrl.text=userController.name.value;
                      Get.back();
                    }
                  }),

                  Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      phoneBox(w*0.44, "رقم الجوال",userController.phone,phone, userController.phoneContrl),
                      phoneBox(w*0.44, "رقم الواتساب",userController.wats,wats, userController.watsContrl),
                    ],
                  ),
                  Box("الايميل",userController.email,email, w, userController.emailContrl,false,(){
                    String newVal=userController.emailContrl.text.trim();
                    if(newVal!=userController.email.value.trim()){
                      if (!RegExp(validEmail).hasMatch(newVal))
                        msg.value='برجاء ادخال ايميل صحيح';
                      else {
                        email.value= newVal;
                        change.value=true;
                        msg.value='';
                        Get.back();
                      }
                    } else {
                      userController.emailContrl.text=userController.email.value;
                      Get.back();
                    }
                  }),
                  socailBox(w, "الموقع الالكتروني", userController.site,site, userController.siteContrl),
                  Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      socailBox(w*0.44, "فيسبوك", userController.face,face, userController.faceContrl),
                      socailBox(w*0.44, "تويتر", userController.twitter,twitter, userController.twitterContrl),
                    ],
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      socailBox(w*0.44, "انستجرام", userController.insta,insta, userController.instaContrl),
                      socailBox(w*0.44, "سناب شات", userController.snap,snap, userController.snapContrl),
                    ],
                  ),
                  userType.value=="provider"?Column(crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Txt("العنوان", mainColor, 16, FontWeight.w500),
                      Container(decoration: Dec(),
                        child: Obx(() => InputFile(userController.mapAddress.isEmpty?
                        userController.address.value:userController.mapAddress.value, Colors.white, w,40,null, ()async{
                          Get.toNamed("/map",arguments: [false,userController.addressLat.value,
                            userController.addressLong.value,userController.saveLoc]);
                          bool online=await connection();
                          if(!online){
                            Popup(" يرجي التاكد من الاتصال بالانترنت ");
                            closePop();
                          }
                        })),
                      ),
                    ],
                  ):SizedBox(height: 0),
                  Box("كلمة المرور","********".obs,"".obs, w, userController.pass1Contrl,true,(){
                    msg.value = '';
                    String oldPass=userController.pass.value.trim(),
                    pass1=userController.pass1Contrl.text.trim(),
                        pass2=userController.pass2Contrl.text.trim();
                    print(oldPass);
                    print(pass1);
                    print(pass2);
                    if(pass1!=pass2) {
                      if (pass1 != oldPass)
                        msg.value = 'كلمة المرور القديمة غير صحيحة';
                      else if (pass2.length < 8)
                        msg.value = 'يجب الا تقل كلمة المرور عن 8 احرف';
                      else {
                        msg.value = '';
                        change.value=true;
                        pass.value = pass2;
                        Get.back();
                      }
                    }else  msg.value = 'ادخل كلمة مرور جديدة';
                  }),
                  // Spacer(),
                  SizedBox(height: 20),
                  Btn(Obx(() => userController.loading.isTrue?CircularProgressIndicator(color: Colors.white,):btnTxt("تغيير")),
                      Colors.white, mainColor, mainColor,width, ()async{
                    // bool change=name.isNotEmpty||phone.isNotEmpty||wats.isNotEmpty||email.isNotEmpty||
                    //     userController.mapAddress.isNotEmpty||pass.isNotEmpty||site.isNotEmpty||face.isNotEmpty||snap.isNotEmpty||changeImg.isTrue;
                    // print(userController.token.value);
                    bool send=change.isTrue||userController.mapAddress.isNotEmpty;
                    print(send);
                    if(send){
                      await userController.updateData(name.value,phone.value,wats.value,email.value,
                          address.value,site.value,face.value,twitter.value,insta.value,snap.value,pass.value);
                      // print(userController.pass.value);
                      change.value=false;
                    }
                  }),
                  SizedBox(height:5),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  Dec(){
    return BoxDecoration(color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,blurRadius: 3,
            offset: Offset(0, 3))]);
  }
  Widget Box(String title,Rx<String> txt,Rx<String> newVal,double w,TextEditingController contrl,bool pass,save){
    var showMsg=false.obs;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Txt(title, mainColor, 16, FontWeight.w500),
          GestureDetector(
            child: Container(width: w,height:40,
              padding: EdgeInsets.all(8),alignment: Alignment.centerRight,
              decoration: Dec(),
              child:SingleChildScrollView(scrollDirection: Axis.horizontal,
                  child:Obx(() => Txt(newVal.isEmpty?txt.value:newVal.value, Colors.black, 17, FontWeight.w600))),
            ),
            onTap: (){
              msg.value="";
              Get.defaultDialog(
                  title: " تغيير $title",
                  titleStyle: TextStyle(color: mainColor,fontFamily: "Kufam",fontWeight: FontWeight.w600),
                  content: Directionality(textDirection: TextDirection.rtl,
                      child: Column(
                          children: [
                            Input(TextInputType.text,pass?"كلمة المرور القديمة":"", contrl, width*0.8, 50, null, (val){}, (val){}),
                            SizedBox(height: 10),
                            pass?Input(TextInputType.text,"كلمة المرور الجديدة",userController.pass2Contrl, width*0.8, 50, null, (val){}, (val){}):
                            SizedBox(height:2),
                            Obx(() => msg.isNotEmpty?Txt(msg.value, Colors.red, 16, FontWeight.w500)
                                :SizedBox(height: 0)),
                            SizedBox(height: 10),
                            Btn(btnTxt("حفظ"), Colors.white, mainColor, mainColor,width*0.8, save)
                          ])) );
            },
          ),
        ],
      ),
    );
  }
  validateUrl(link){
    return Uri.tryParse(link)?.hasAbsolutePath ?? false;
  }
  Widget ImgBox(){
    print(userController.img.value);
    var img;
   setState(() {
     if(imgPath.path.isEmpty){
       if(userController.img.value.isEmpty)
         img=AssetImage("imgs/man.png");
       else img=NetworkImage(userController.img.value);
     }else img=FileImage(imgPath);
   });
    return CircleAvatar(radius: 60,backgroundColor: inputColor,
        backgroundImage:img);
  }
  uploadImg()async{
    final ImagePicker picker = ImagePicker();
    var pickedImage = await picker.pickImage(source: ImageSource.gallery,);
    if (pickedImage != null) {
      setState(() =>imgPath =File(pickedImage.path));
      setState(() =>img=imgPath.path);
      userController.imgFile.value=imgPath;
      changeImg.value = true;
      change.value = true;
    } else {
      print('please pick an image');
    }
  }

  socailBox(double w,String title,Rx<String> oldVal,Rx<String> stipnVal,TextEditingController newVal){
    return Box(title,oldVal,stipnVal, w, newVal,false,(){
      if(newVal.text.trim()!=oldVal.value.trim()){
        if (!validateUrl(newVal.text)) {
          msg.value = "(https://site.com/) برجاء ادخال رابط يحتوي ع هذه الرموز";
        } else {
          stipnVal.value= newVal.text;
          change.value=true;
          msg.value='';
          Get.back();
        }
      } else {
        newVal.text=oldVal.value;
        Get.back();
      }
    });
  }
  phoneBox(double w,String title,Rx<String> oldVal,Rx<String> stipnVal,TextEditingController newVal){
    return Box(title,oldVal,stipnVal, w, newVal,false,(){
      if(newVal.text.trim()!=oldVal.value.trim()){
        if (!RegExp(validPhone).hasMatch(newVal.text))
          msg.value='برجاء ادخال رقم صحيح';
       else {
        stipnVal.value= newVal.text;
        change.value=true;
        msg.value='';
        Get.back();
      }} else {
        newVal.text=oldVal.value;
        Get.back();
      }
    });
  }
  initSite(Rx<String> oldVal,Rx<String> stipnVal){
    // List sites=[userController.site,userController.face,userController.twitter,userController.snap,userController.insta];
    if(oldVal.isEmpty){
      stipnVal.value="ضف لينك";
    }
  }
  initAllSites(){
    initSite(userController.site, site);
    initSite(userController.face, face);
    initSite(userController.twitter, twitter);
    initSite(userController.snap, snap);
    initSite(userController.insta, insta);
  }
}
