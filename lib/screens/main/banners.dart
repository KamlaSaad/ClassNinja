import 'dart:io';

// import 'package:class_ninja/controllers/banner_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';

import '../../controllers/call_Contrls/share_banner.dart';
import '../../widgets/bottom_bar.dart';
import '../../widgets/main_box.dart';
import '../../widgets/shared.dart';
class Banners extends StatefulWidget {
 Banners({Key? key}) : super(key: key);

  @override
  State<Banners> createState() => _BannersState();
}

class _BannersState extends State<Banners> {
  // BannerController controller=Get.put(BannerController());
  var imgFile=File("").obs;
  @override
  void initState() {
    if(controller.myBanners.isEmpty){
      controller.getBanners();
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    // if(controller.myBanners.isEmpty){
    //   controller.getBanners();
    // }
    return Directionality(textDirection: TextDirection.rtl,
        child: Scaffold(appBar:MainBar("لافتاتي",27, false,false),
        body: Stack(
          children: [
            Container(
                width: width, height: height,
                padding: EdgeInsets.only(right: 10,left: 10,bottom: height*0.1),
                child: Obx(() =>
                      controller.myBanners.isNotEmpty ?
                      GridBox() : controller.online.isTrue ?
                      (controller.loading.isTrue?
                      Center(child: CircularProgressIndicator(color: mainColor))
                          : Center(child: Txt(
                          "لايوجد عناصر بعد", Colors.black, 15, FontWeight.w600)))
                     : Center(child: Txt(
                          "لايوجد اتصال بالانترنت", Colors.black, 15,
                          FontWeight.w600),))
                ),
            Positioned(left: 0,bottom: 0,
                child: BottomBar(width, [false,false,true,false,false])),
            Positioned(left: 6,bottom: height*0.1,
                child: CircleAvatar(radius: 28,
                    backgroundColor: mainColor,child: IconButton(icon: Icon(Icons.add,size: 28,),
                        onPressed: ()=>loadImg()))),
        ])));
  }

  Widget Box(String img,String status){
    return Container(alignment: Alignment.bottomRight,
      decoration: BoxDecoration(color: inputColor,
          image: img.isNotEmpty
              ? DecorationImage(
              image: NetworkImage(img), fit: BoxFit.fill)
              : null,
          borderRadius: BorderRadius.circular(10)),
      child: Txt(status, Colors.black, 18, FontWeight.w600)
    );
  }

  chooseImg()async{
    final ImagePicker picker = ImagePicker();
    var pickedImage = await picker.pickImage(source: ImageSource.gallery,);
    if (pickedImage != null) {
      imgFile.value =File(pickedImage.path);
      controller.imgPath.value=imgFile.value;
    } else {
      print('please pick an image');
    }
  }

  loadImg()async{
    var loading=false.obs;
    await chooseImg();
    if(imgFile.value.path.isNotEmpty){
      Get.defaultDialog(
        title: "اضافة لافتة",titleStyle: TxtStyle(mainColor,20,FontWeight.w700),
        content: Column(
          children: [
            Container(width: width*0.8,height: 200,
              decoration: BoxDecoration(color: inputColor,
                      image:DecorationImage(image: FileImage(imgFile.value),fit: BoxFit.fill),
                  borderRadius: BorderRadius.circular(10)),
            ),
            SizedBox(height: 12),
            SizedBox(height: 40,
                child: Btn(Obx(() => loading.isTrue?CircularProgressIndicator(color: Colors.white):
                btnTxt("ارسال")), Colors.white, mainColor, mainColor,width*0.8, ()async{
                  loading.value=true;
                  //action
                  await controller.addBanner();
                  loading.value=false;
                }))
          ],
        )
      );
    }
  }

  GridBox(){
    return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(mainAxisExtent:  180,
            mainAxisSpacing: 0,crossAxisSpacing: 5,crossAxisCount: 2),
        itemCount: controller.myBanners.length,
        itemBuilder: (context,i) {
          var item = controller.myBanners.value[i];
          var icon;
          icon = IconButton(icon: Icon(Icons.clear,size: 14, color:Colors.red),
              onPressed: ()async{
                print(item['id']);
                confirmBox("حذف اللافتة", "هل انت متاكد من حذف اللافتة؟",
                        ()async{await controller.deleteBanner(item['id']);});
              });
          String status=item['status'].toString().trim()!="accepted"?"لم يتم الموافقة بعد":"تمت الموافقة",
              img = item['image'] ?? "";

          return MainBox(width*0.42,img, icon,true,0, "","", "", status);
          // return Box(img, status);
        }
    );
  }
}
