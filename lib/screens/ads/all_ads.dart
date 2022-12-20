import 'dart:async';

import 'package:class_ninja/controllers/get_token.dart';
import 'package:class_ninja/widgets/main_box.dart';
import 'package:class_ninja/widgets/shared.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/fav_controller.dart';

class AllAds extends StatelessWidget {
  AllAds({Key? key}) : super(key: key);
  FavController favController=Get.put(FavController());
  var name=TextEditingController(),
      phone=TextEditingController();
  List ads=Get.arguments;
  @override
  Widget build(BuildContext context) {
    return Directionality(textDirection: TextDirection.rtl,
        child: Scaffold(
            appBar: AppBar(elevation: 0,backgroundColor: Colors.white,
              leading: BackButton(color: Colors.black,),
              title: Txt("الاعلانات المميزة", mainColor, 26, FontWeight.bold),
            ),
            body:ads.length>0?GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(mainAxisExtent:  220,
                    mainAxisSpacing: 0,crossAxisSpacing: 5,crossAxisCount: 2),
                itemCount: ads.length,
                itemBuilder: (context,i){
                  var item=ads[i];
                  bool fav=myFavIds.contains(item['id']);
                  String adrs="",address="";
                  var provider=item['provider'];
                  if(provider!=null){
                    adrs=item['provider']['address'];
                    address=adrs.trim()=="العنوان"?"":adrs;
                  }
                  String  type=item['type']!="shop"?"(للكشف)":"";
                  return  GestureDetector(onTap: (){
                    if(provider!=null ) {
                      print(provider['id']);
                      Get.toNamed("/details",arguments: provider['id']);
                    }
                    }, child: MainBox(width*0.42,item['image'], fav, "${item['price']}",item['title'], type, address,(){
                    if(userType.value=="client" && fav!=true) {
                      print(item['id']);
                      confirmBox(
                          "اضافة الاعلان", "هل تريد اضافة الاعلان الي المفضلة",
                              () async {
                            Get.back();
                            await favController.addFav("${item['id']}");
                          });
                    }
                  }));}

            ):Center(child: Txt("لايوجد اعلانات مميزة", Colors.black, 16, FontWeight.w500)))
    );
  }
  void Dialog(){
    Get.defaultDialog(
        title: "للاستفادة من الاعلان ادخل البيانات التالية ",
        titleStyle: TextStyle(color: mainColor,fontFamily: "Kufam",fontWeight: FontWeight.w600),
        content: Directionality(textDirection: TextDirection.rtl,
          child: Column(
            children: [
              Input(TextInputType.text,"اسم المستخدم", name, width*0.8, 50, null, (val){}, (val){}),
              SizedBox(height: 10),
              Input(TextInputType.phone,"رقم الجوال", phone, width*0.8, 50, null, (val){}, (val){}),
              SizedBox(height: 10),
              Btn(btnTxt("ارسال"), Colors.white, mainColor, mainColor,width*0.8, (){
                if(name.text.isNotEmpty &&phone.text.isNotEmpty){
                  Get.back();
                  Timer(Duration(seconds: 1), ()=>Popup("ينكتك الان الاستفادة من العرض"));
                }
              })
            ],
          ),
        )
    );
  }
}
