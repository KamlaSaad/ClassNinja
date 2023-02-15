
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import '../../controllers/ad_controller.dart';
import '../../controllers/call_Contrls/share_ads.dart';
import '../../widgets/bottom_bar.dart';
import '../../widgets/main_box.dart';
import '../../widgets/shared.dart';
class MyAds extends StatefulWidget {
  MyAds({Key? key}) : super(key: key);

  @override
  State<MyAds> createState() => _MyAdsState();
}

class _MyAdsState extends State<MyAds> {
  @override
  void initState() {
    if(adController.myAds.isEmpty){
      adController.getMyAds();
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Directionality(textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: MainBar('اعلانتي',28, false, false),
          body: Stack(
            children: [
              Container(
                  width: width, height: height,
                  padding: EdgeInsets.only(right: 10,left: 10,bottom: height*0.1),
                  child: Obx(() => adController.myAds.isNotEmpty?GridBox():
                adController.online.isTrue?(adController.loading.isTrue?
                Center(child: CircularProgressIndicator(color: mainColor))
                    : Center(child: Txt(
                    "لايوجد عناصر بعد", Colors.black, 15, FontWeight.w600)))
                    : Center(child: Txt(
                    "لايوجد اتصال بالانترنت", Colors.black, 15,
                    FontWeight.w600),))),
              Positioned(left: 0,bottom: 0,
                  child: BottomBar(width, [false,true,false,false,false])),
              Positioned(left: 6,bottom: height*0.1,
                  child: CircleAvatar(radius: 28,
                      backgroundColor: mainColor,child: IconButton(icon: Icon(Icons.add,size: 28,),
                      onPressed: ()=>Get.toNamed("/ads")))),
            ],
          ),
        ),
    );
  }

  GridBox(){
    return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(mainAxisExtent:  220,
            mainAxisSpacing: 0,crossAxisSpacing: 5,crossAxisCount: 2),
        itemCount: adController.myAds.length,
        itemBuilder: (context,i){
          var item=adController.myAds.value[i];
          String status=item['status'].toString().trim()!="accepted"?"لم يتم الموافقة بعد":"تمت الموافقة";

          // print(status);
          var icon;
          icon = IconButton(icon: Icon(Icons.clear,size: 14, color:Colors.red),
              onPressed: ()async{
                print(item['id']);
                confirmBox("حذف الاعلان", "هل انت متاكد من حذف هذا الاعلان؟", ()async{await adController.deleteAd(item['id']);});
              });
          return  GestureDetector(onTap: (){
          }, child: MainBox(width*0.42,item['image'], icon,true,item['id'], "SR ${item['price']}",item['title'], "", status));}
    );
  }

  FutureBox() {
    return FutureBuilder(
        future:adController.getMyAds(),
        builder: (context, AsyncSnapshot snap) {
          List data = snap.data??[];
          if (data.isNotEmpty) {
            adController.myAds.value = data;
          }
          return adController.loading.isTrue?
          Center(child: CircularProgressIndicator(color: mainColor)):
          data.length > 0 ? GridBox()
              : Center(child: Txt(
              "لايوجد اعلانات بعد", Colors.black, 15, FontWeight.w600));
        });
  }
}
