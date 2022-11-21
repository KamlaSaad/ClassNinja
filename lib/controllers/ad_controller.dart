import 'dart:convert';
import 'package:path/path.dart';
import 'package:class_ninja/widgets/shared.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
class AdController extends GetxController{
  var img="رفع الصورة".obs,
  adName=TextEditingController(),
  adPrice=TextEditingController();
  late File imgPath;
  uploadImg()async{
    final ImagePicker picker = ImagePicker();
      var pickedImage = await picker.pickImage(source: ImageSource.gallery,);
      if (pickedImage != null) {
        imgPath =File(pickedImage.path);
        img.value=imgPath.path.split('/').last;
        // final bytes = imgPath.readAsBytesSync();
        // String img64 = base64Encode(bytes);
        // update();
        // print('Image Succ uplaoded');
        // decodedBytes  = base64Decode(img64);
        // print(decodedBytes);
      } else {
        print('please pick an image');
      }
  }
  void createAd(){
    if(img.isNotEmpty &&adName.text.isNotEmpty &&adPrice.text.isNotEmpty){
      Get.defaultDialog(backgroundColor: inputColor,
        title: ".",titleStyle: TextStyle(fontSize: 0,height: 0),
        content:  Center(child: Txt("ستتم مراجعة الاعلان من قبل الادارة قبل نشره", mainColor, 20, FontWeight.bold))
      );
      img.value="رفع الصورة";
      adName.text="";
      adPrice.text="";
      // Get.dialog(
      //   Txt("ستتم مراجعة الاعلان من قبل الادارة قبل نشره", mainColor, 22, FontWeight.bold),
      // );
    }
  }
}