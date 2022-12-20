import 'package:class_ninja/controllers/fav_controller.dart';
import 'package:class_ninja/widgets/main_box.dart';
import 'package:class_ninja/widgets/shared.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../widgets/bottom_bar.dart';
class Favourite extends StatelessWidget {
   Favourite({Key? key}) : super(key: key);
  FavController favController=Get.put(FavController());
  @override
  Widget build(BuildContext context) {
    return Directionality(textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar:MainBar('المفضلة',26, false,false),
          body: Stack(
            children: [
              Container(
                  width: width,height: height,
                  padding: EdgeInsets.all(10),
                  child: SingleChildScrollView(child:
                  Column(children: [
                    // SizedBox(height: 15),
                    SizedBox(height: height*0.8,
                        child:Obx(() => favController.online.isTrue?(favController.loading.isTrue?
                        Center(child: CircularProgressIndicator(color: mainColor)):
                        favController.myFavs.length>0?
                        GridView.builder(
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(mainAxisExtent:  220,
                                mainAxisSpacing: 0,crossAxisSpacing: 5,crossAxisCount: 2),
                            itemCount: favController.myFavs.length,
                            itemBuilder: (context,i){
                              var favId=favController.myFavs[i]['id'];
                              var item=favController.myFavs[i]['ad'];
                              // print("=====ad ${item['id']}==========");
                              // print(item);
                              String title=item['title'],
                                  // adrs=item['provider']['address'],
                                  // address=adrs.trim()=="العنوان"?"":adrs,
                                  img=item['image'];
                              var price=item['price'],
                                  provider=item['provider'];
                              String adrs="",address="";
                              if(provider!=null){
                                adrs=provider['address'];
                                address=adrs.trim()=="العنوان"?"":adrs;
                              }
                              return  GestureDetector(onTap: (){
                              },
                                  child: MainBox(width*0.42,img, true, "$price",title, "", address,()async{
                                    print(item);
                                    confirmBox("حذف الاعلان", "هل تريد حذف هذا الاعلان من المفضلة؟", ()async{
                                      Get.back();
                                      await favController.delFav("$favId");
                                    });
                                  }));}
                        ):Center(child:Txt("لايوجد عناصر بعد", Colors.black, 15, FontWeight.w600)))
                        : Center(child: Txt("لايوجد اتصال بالانترنت", Colors.black, 15, FontWeight.w600),))
                    )
                  ],),)),
              Positioned(left: 0,bottom: 0,
                  child: BottomBar(width, [false,false,false,true,false]))
            ],
          ),
        ));
  }
   // FutureBox(){
   //   return  FutureBuilder(
   //       future: favController.getMyFav(),
   //       builder: (context, AsyncSnapshot snap) {
   //         switch (snap.connectionState) {
   //           case ConnectionState.none:
   //             return Center(child: Txt("لايوجد اتصال بالانترنت", Colors.black, 15, FontWeight.w600));
   //           case ConnectionState.active:
   //           case ConnectionState.waiting:
   //             return Center(child:  CircularProgressIndicator(color: mainColor));
   //           case ConnectionState.done:
   //             if (snap.hasError) {
   //               print("=======Error==========");
   //               print(snap.error);
   //             }
   //             var data = snap.data;
   //             return data!=null?
   //
   //         }}
   //   );
   // }
}
