
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../controllers/call_Contrls/share_fav.dart';
import '../../widgets/bottom_bar.dart';
import '../../widgets/main_box.dart';
import '../../widgets/shared.dart';
class Favourite extends StatefulWidget {
  const Favourite({Key? key}) : super(key: key);

  @override
  State<Favourite> createState() => _FavouriteState();
}

class _FavouriteState extends State<Favourite> {
  @override
  void initState() {
    if(favController.myFavs.isEmpty){
     favController.getMyFav();
    }
    super.initState();
  }
  // FavController favController=Get.put(FavController());
  @override
  Widget build(BuildContext context) {
    return Directionality(textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: MainBar('المفضلة', 26, false, false),
          body: Stack(
            children: [
            Container(
            width: width, height: height,
            padding: EdgeInsets.only(right: 10,left: 10,bottom: height*0.1),
            child: Obx(()=>
                        favController.myFavs.isNotEmpty ?
                        GridBox() : favController.online.isTrue ?
                        (favController.loading.isTrue?
                        Center(child: CircularProgressIndicator(color: mainColor))
                            : Center(child: Txt(
                            "لايوجد عناصر بعد", Colors.black, 15, FontWeight.w600)))
                            : Center(child: Txt(
                            "لايوجد اتصال بالانترنت", Colors.black, 15,
                            FontWeight.w600),))
                   ,),
              Positioned(left: 0, bottom: 0,
                  child: BottomBar(width, [false, false, false, true, false]))
            ],
          ),
        ));
  }

  GridBox() {
    return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            mainAxisExtent: 235,mainAxisSpacing: 0, crossAxisSpacing: 0, crossAxisCount: 2),
        itemCount: favController.myFavs.length,
        itemBuilder: (context, i) {
          var favId = favController.myFavs[i]['id'];
          var item = favController.myFavs[i]['ad'];
          // print("=====ad ${item['id']}==========");
          // print(item);
          String title = item['title'],
              type=item['type']=="shop"?"":"(للكشف)",
          // adrs=item['provider']['address'],
          // address=adrs.trim()=="العنوان"?"":adrs,
              img = item['image'];
          var price = item['price'],
              provider = item['provider'];
          String adrs = "",
              address = "";
          if (provider != null) {
            adrs = provider['address'];
            address = adrs.trim() == "العنوان" ? "" : adrs;
          }
          var icon;
          icon = IconButton(
              icon: Icon(Icons.clear_outlined, size: 15, color: Colors.red),
              onPressed: () async {
                print(item);
                confirmBox("حذف الاعلان",
                    "هل تريد حذف هذا الاعلان من المفضلة؟", () async {
                      Get.back();
                      await favController.delFav("$favId");
                    });
              });
          return GestureDetector(onTap: () {},
              child: MainBox(
                  width * 0.43,
                  img,
                  icon,true,
                  item['id'],
                  "SR $price",
                  title,
                  type,
                  address));
        }
    );
  }
}