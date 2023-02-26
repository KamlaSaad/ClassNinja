import 'package:E3yoon/controllers/get_token.dart';
import 'package:E3yoon/screens/auth/share_contrl.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/call_Contrls/share_chat.dart';
import '../../controllers/conn.dart';
import '../../controllers/details_Controller.dart';
import '../../widgets/shared.dart';
import 'package:url_launcher/url_launcher.dart';

class Details extends StatefulWidget {
  const Details({Key? key}) : super(key: key);

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  DetailsController contrl=Get.put(DetailsController());
  double w=width*0.9;
  int providerId=Get.arguments;
  @override
  void initState(){
    contrl.getData(providerId);
    super.initState();
    // await loc.goToMaps();
    // address=loc.getAdress(loc.latitude.value,loc.longitude.value);
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(elevation: 0,
          leading: BackButton(color: Colors.black),
          title: null,backgroundColor: Colors.white,
        ),
        body: Center(
          child: Obx(() =>contrl.online.isTrue?(
          contrl.loading.isTrue?CircularProgressIndicator(color: mainColor):
          contrl.data.isNotEmpty?SingleChildScrollView(child:Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(height: 150,width: w,
                  decoration: BoxDecoration(color: inputColor,
                      image: DecorationImage(image: NetworkImage(contrl.data['image']??""),fit:BoxFit.fill),
                      borderRadius: BorderRadius.circular(10))),
              SizedBox(height: 20),
              Container(width: w,
                padding: EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(color: inputColor,
                    borderRadius: BorderRadius.circular(10)),
                child: Column(mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(width: width*0.7,child: SingleChildScrollView(scrollDirection: Axis.horizontal,
                            child:Txt(contrl.data['name'], Colors.black, 18, FontWeight.bold),)),
                            contrl.data['id'].toString().trim()!=userController.id.value &&userToken.isNotEmpty?IconButton(onPressed: (){
                              print(contrl.data['id']);
                              print(userController.id.value);
                              String id="provider${contrl.data['id']}";
                              Map chat=chatContrl.getChatByUsers(id);
                              if(chat.isEmpty){
                                chatContrl.chatId.value="";
                                chatContrl.chat.value={"id":"","name":contrl.data['name'],
                                  "img":contrl.data['image']??"", "receiver":id };
                              }else{
                                chatContrl.chatId.value=chat['id'];
                                chatContrl.chat.value=chat;
                              }
                              print(chatContrl.chat['id']);
                              Get.toNamed("/chat");
                            }, icon: Icon(Icons.message,size: 28,)):SizedBox(width: 0,)
                          ],
                        ),
                      ),
                      SizedBox(height: 5),
                      Container(height: 1,width: w,color: mainColor),
                      Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          contact(contrl.data.value['phone'],  Colors.blue, true),
                          Container(height: 60,width: 1,color: mainColor),
                          contact(contrl.data.value['whatsapp'],  Colors.green, false)
                        ],
                      ),
                      Container(height: 1,width: w,color: mainColor),
                      Container(height: 45,
                        // alignment: Alignment.centerRight,
                        child: ListTile(
                          leading: Image.asset("imgs/map.png",width: 40,height: 40),
                          title: Directionality(textDirection: TextDirection.ltr,
                              child: Address(contrl.data['address'])
                          ),
                          onTap: ()async{
                            // print(contrl.data['activity']!="shop");
                            await contrl.goToMap();
                            bool online=await connection();
                            if(!online){
                              Popup(" يرجي التاكد من الاتصال بالانترنت ");
                              closePop();
                            }
                          },
                        ),
                      )
                    ]),
              ),
              SizedBox(height: 20),
              //============banners==============
              Sliderer(),
              SizedBox(height: 3),
              //=============ads=================
              ListItem("", "الاعلانات", contrl.ads,width*0.92,contrl.data['activity']=="shop",false,false),
              SizedBox(height: 20),
              Container(height: 150,width: w,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(color: inputColor,
                    borderRadius: BorderRadius.circular(10)),
                child: Column(children: [
                  Txt("يمكنك متابعتنا علي مواقع التواصل الاجتماعي", Colors.black, 17, FontWeight.bold),
                  SizedBox(height: 10),
                  Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Social("www",contrl.data['website']),
                      Social("twitter",contrl.data['twitter']),
                      Social("snapchat",contrl.data['snap_chat']),
                      Social("insta",contrl.data['instagram']),
                      Social("face",contrl.data['facebook']),

                    ],
                  )
                ]),
              ),
            ],)):Txt("عفوا حدث خطا ما", Colors.black, 17, FontWeight.w600)):
              Center(child: Txt("لايوجد اتصال بالانترنت", Colors.black, 15, FontWeight.w600),),
      )

    )));
  }
  Widget contact(String phone,Color color,bool tel){
    return SizedBox(width: w*0.45,height: 60,
      child: SingleChildScrollView(scrollDirection: Axis.horizontal,
          child:GestureDetector(
            child: Row(
              children: [
                CircleAvatar(radius: 16,backgroundColor: color,child: Icon(Icons.call,color: Colors.white)),
                SizedBox(width: 5),
                Txt(phone, Colors.black, 18, FontWeight.w600),
              ],
            ),
            onTap: (){
              // print(contrl.data.value);
              if(tel) launch("tel://$phone");
              else contrl.whatsLauncher(phone);
            },
          )),
    );
  }
  Widget Social(String img,String url){
    return GestureDetector(onTap:()=>contrl.siteLauncher(url),
        child: CircleAvatar(radius: 22,backgroundImage: AssetImage("imgs/$img.png"),));
  }
  Widget Address(String txt){
    return SingleChildScrollView(scrollDirection: Axis.horizontal,
        child:Txt(txt, Colors.black, 17, FontWeight.w700));
  }
  SliderBox(image){
    return Container(height: 200,width: w,margin: EdgeInsets.symmetric(horizontal:5),
        decoration: BoxDecoration(color: inputColor,image: DecorationImage(image: image,fit:BoxFit.fill),
            borderRadius: BorderRadius.only(bottomRight: Radius.circular(10),bottomLeft:Radius.circular(10) )));
  }
  Widget Sliderer(){
    return Obx(() => contrl.banners.isNotEmpty?
    SizedBox(width: width*0.9,
      child: CarouselSlider(
          options: CarouselOptions(height:190,autoPlay: false,viewportFraction: 0.92),
          items: contrl.banners.map((i) {
            return Builder(
                builder: (BuildContext context) {
                  return  SliderBox( NetworkImage(i['image']));
                });
          }).toList()),
    ):SliderBox(AssetImage("imgs/sale.png")));
  }
}
