import 'package:class_ninja/controllers/home_controllers.dart';
import 'package:class_ninja/widgets/bottom_bar.dart';
import 'package:class_ninja/widgets/shared.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../widgets/main_box.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);
  HomeController homeController=Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return Directionality(textDirection: TextDirection.rtl,
    child: Scaffold(
      appBar:MainBar("الرئيسية",27, false,false),
      body: Stack(
        children: [
          Container(
            width: width,height: height,
            padding: EdgeInsets.all(10),
            child: SingleChildScrollView(child:
                Column(children: [
                  SizedBox(height: 15),
                  Container(height: 180,width: width*0.9,
                      decoration: BoxDecoration(color: Colors.white,
                          image: DecorationImage(image: AssetImage("imgs/sale.png"),fit:BoxFit.fill),
                          borderRadius: BorderRadius.circular(10) )),
                  SizedBox(height: 10),
                  ListItem("محلات ", "النظارات", homeController.shops,true),
                  ListItem("دكاترة ", "ومستشفيات", homeController.doctors,false),
                  SizedBox(height: 20),
                  //ads
                  Titles(" الاعلانات ", "المميزة", ()=>Get.toNamed("/allAds")),
                  SingleChildScrollView(scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        MainBox(width*0.42,"", false, "1500.00","ا.د/يوسف علي", "(للكشف)", "الرياض السعودية",(){}),
                        MainBox(width*0.42,"", false, "1500.00","ا.د/يوسف علي", "(للكشف)", "الرياض السعودية",(){}),
                      ],),
                  ),
                  SizedBox(height: 50),
                ],),
          )),
          Positioned(left: 0,bottom: 0,
              child: BottomBar(width, [true,false,false,false]))
        ],
      ),
    ));
  }
  Widget ListItem(String txt1,String txt2,RxList<dynamic> list,bool shop){
    return Column(
      children: [
        Titles(txt1, txt2, ()=>Get.toNamed("/homeAds",arguments: [shop,list])),
        // Titles(txt1, txt2, ()=>print(myFavIds.value)),
        SizedBox(height: 10),
        SizedBox(
          height: 50,width: width*0.95,
          child: Obx(() => ListView.builder(itemCount: list.length,scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext contxt,i){
               String img=list[i]['image'];
                return  Container(margin: EdgeInsets.symmetric(horizontal: 5),
                    color: inputColor,
                    height: 40,width: 150,child: GestureDetector(onTap: ()async{
                      // print(homeController.shops.value);
                    },
                        child: img.isEmpty?null:Image(image: NetworkImage(img),fit: BoxFit.fill)));
              })),
        )
      ],
    );
  }
  Widget Titles(String t1,String t2,action){
    return SingleChildScrollView(scrollDirection: Axis.horizontal,
      child:Container(width: width*0.95,child:Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Txt(t1, Colors.black, 18, FontWeight.w500),
              Txt(t2, Colors.black, 19, FontWeight.bold),
            ],
          ),
          TxtBtn("مشاهدة الكل", mainColor, 15, action)
        ],
      )),
    );
  }
}
