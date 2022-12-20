import 'package:carousel_slider/carousel_slider.dart';
import 'package:class_ninja/controllers/get_token.dart';
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
                  //banners slider
                  Sliderer(),
                  SizedBox(height: 10),
                  ListItem("محلات ", "النظارات", homeController.shops,width*0.95,true,true),
                  ListItem("دكاترة ", "ومستشفيات", homeController.doctors,width*0.95,false,true),
                  SizedBox(height: 20),
                  //ads
                  Titles(" الاعلانات ", "المميزة",width*0.95, ()=>Get.toNamed("/allAds",arguments: homeController.specialAds.value)),
                  SpecialAds(),
                  SizedBox(height: 50),
                ],),
          )),
          Positioned(left: 0,bottom: 0,
              child: BottomBar(width, [true,false,false,false,false]))
        ],
      ),
    ));
  }
  SliderBox(image){
    return Container(height: 180,width: width*0.95,
        margin:EdgeInsets.symmetric(horizontal: 6),
        decoration: BoxDecoration(color: Colors.white,
            image: DecorationImage(image: image,fit:BoxFit.fill),
            borderRadius: BorderRadius.circular(10) ));
  }
  Widget Sliderer(){
    return Obx(() => homeController.banners.isNotEmpty?
    CarouselSlider(
        options: CarouselOptions(height: 200.0,autoPlay: true),
        items: homeController.banners.map((i) {
          return Builder(
            builder: (BuildContext context) {
              return  SliderBox( NetworkImage(i['image']));
            });
        }).toList()):SliderBox(AssetImage("imgs/sale.png")));
  }

  SpecialAds(){
    int adsLen=homeController.specialAds.length,
        len= adsLen>=2?2:1;
    return  Obx(() =>homeController.specialAds.length>0?Container(width: width*0.95,height: 220,
      child:GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(mainAxisExtent:  220,
              mainAxisSpacing: 0,crossAxisSpacing: 5,crossAxisCount: 2),
          itemCount: homeController.specialAds.length>=2?2:1,
          itemBuilder: (context,i){
            var item=homeController.specialAds.value[i];
            String  type=item['type']!="shop"?"(للكشف)":"",
                    address=item["provider"]!=null?item["provider"]['address']:"";
            print(address);
            return  GestureDetector(onTap: (){},child:
            MainBox(width*0.42,item['image'], false, "${item['price']}",item['title'], type, address,(){}));}

      )
    ):SizedBox(height: 0,));
  }
}
