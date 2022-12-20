import 'dart:async';
import 'package:class_ninja/controllers/get_token.dart';
import 'package:class_ninja/widgets/main_box.dart';
import 'package:class_ninja/widgets/shared.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// import '../../controllers/fav_controller.dart';
import '../../controllers/fav_controller.dart';
import '../../controllers/home_controllers.dart';
class HomeAds extends StatelessWidget {
  HomeAds({Key? key}) : super(key: key);
  HomeController homeController=Get.put(HomeController());
  FavController favController=Get.put(FavController());
  bool shop=Get.arguments[0],
       general=Get.arguments[2];
  List data=Get.arguments[1];
  // List favList=Get.arguments[1];

  @override
  Widget build(BuildContext context) {
    print(myFavIds.value);
    // List data=shop?homeController.shops:homeController.doctors;
    return Directionality(textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(elevation: 0,backgroundColor: Colors.white,
          leading: BackButton(color: Colors.black,),
          title: Txt(shop?"محلات النظارات":" دكاترة ومستشفيات ", mainColor, shop?22:20, FontWeight.bold),
        ),
        body:Obx(() => homeController.loading.isFalse?(data.length>0?GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(mainAxisExtent:  220,
                mainAxisSpacing: 0,crossAxisSpacing: 5,crossAxisCount: 2),
            itemCount: data.length,
            itemBuilder: (context,i){
              // bool fav=data[i]['fav']??false;
              // print(data[i]['id']);
              bool fav=myFavIds.contains(data[i]['id']);
              var provider=data[i]['provider'];
              String adrs="",address="";
              if(provider!=null){
                adrs=data[i]['provider']['address'];
                address=adrs.trim()=="العنوان"?"":adrs;
              }
              print("address $adrs");
              return  GestureDetector(onTap: ()async{
                // print(favController.favIds.value);
                if(provider!=null && general) {
                   print(provider['id']);
                   Get.toNamed("/details",arguments: provider['id']);
                  }
                },child: MainBox(width*0.42,data[i]['image'], fav,"${data[i]['price']}",
                  data[i]['title'], shop?"":"(للكشف)", address,(){
                    if(userType.value=="client" && fav!=true) {
                      print(data[i]['id']);
                      confirmBox(
                          "اضافة الاعلان", "هل تريد اضافة الاعلان الي المفضلة",
                              () async {
                            Get.back();
                            await favController.addFav("${data[i]['id']}");
                          });
                    }
                  }));}
               ):Center(child: Txt("لايوجد اعلانات بعد", Colors.black, 17, FontWeight.w600),))
            :Center(child: CircularProgressIndicator(color: mainColor)))

      ),
    );
  }

}
