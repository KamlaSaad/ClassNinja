import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/call_Contrls/share_fav.dart';
import '../../controllers/fav_controller.dart';
import '../../controllers/get_token.dart';
import '../../controllers/home_controllers.dart';
import '../../widgets/bottom_bar.dart';
import '../../widgets/main_box.dart';
import '../../widgets/shared.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  HomeController homeController=Get.put(HomeController());
  @override
  void initState() {
    if(homeController.shops.isEmpty &&homeController.specialAds.isEmpty){
      homeController.getData();
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Directionality(textDirection: TextDirection.rtl,
    child: Scaffold(
      appBar:MainBar("الرئيسية",27, false,false),
      body: Stack(
        children: [
          Container(
            width: width,height: height,
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: SingleChildScrollView(child:
                Column(children: [
                  // SizedBox(height: 15)
                  //banners slider
                  Sliderer(),
                  SizedBox(height: 10),
                  ListItem("محلات ", "النظارات", homeController.shops,width*0.95,true,true,true),
                  ListItem("دكاترة ", "ومستشفيات", homeController.doctors,width*0.95,false,true,true),
                  SizedBox(height: 20),
                  //ads
                  Titles(" الاعلانات ", "المميزة",width*0.95, ()=>Get.toNamed("/allAds",arguments: homeController.specialAds.value)),
                  SpecialAds(),
                  SizedBox(height: 75),
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
        options: CarouselOptions(height: 200.0,autoPlay: true,viewportFraction: 0.9),
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
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(mainAxisExtent: userType.value=="client" ?235:225,
              mainAxisSpacing: 0,crossAxisSpacing: 0,crossAxisCount: 2),
          itemCount: homeController.specialAds.length>=2?2:1,
          itemBuilder: (context,i){
            var item=homeController.specialAds.value[i];
            String  type=item['type']!="shop"?"(للكشف)":"",
                    address=item["provider"]!=null?item["provider"]['address']:"";
            // print(address);
            bool fav=myFavIds.contains(item['id']);
            var icon;
            if(userType.value=="client") {
              icon = IconButton(icon: Icon(Icons.favorite,size: 14, color: fav ? Colors.red : Colors.grey),
                  onPressed: () {
                    if (fav != true) {
                      print(item['id']);
                      confirmBox("اضافة الاعلان","هل تريد اضافة الاعلان الي المفضلة",
                              () async {
                            Get.back();
                            await favController.addFav("${item['id']}");
                          });
                    }});
            }
            return  GestureDetector(onTap: ()async{
              var provider=item['provider'];
              if(provider!=null ) {
                print(provider['id']);
                Get.toNamed("/details",arguments: provider['id']);
              }
              // Get.toNamed("/map");
              // await favController.getMyFav();
              // print(favController.myFavs.value);
            },child:
            MainBox(width*0.45,item['image'], icon,true,item['id'], "SR ${item['price']}",item['title'], type, address));}

      )
    ):SizedBox(height: 0,));
  }
}
