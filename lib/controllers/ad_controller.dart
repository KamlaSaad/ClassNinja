import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import '../widgets/shared.dart';
import 'conn.dart';
import 'get_token.dart';
class AdController extends GetxController{
  var myAds=[].obs;
  var img="رفع الصورة".obs,
  msg="".obs,
  online =true.obs,
  loading=false.obs,
  adName=TextEditingController(),
  adPrice=TextEditingController();

  @override
  void onInit() async{
    online.value = await connection();
    if(myAds.isEmpty) {
      myAds.value = await getMyAds();
    }
    // TODO: implement onInit
    super.onInit();
  }
  resetVals(){
    img.value = "رفع الصورة";
    adName.clear();
    adPrice.clear();
  }
  late File imgPath=File("");
  uploadImg()async{
    final ImagePicker picker = ImagePicker();
      var pickedImage = await picker.pickImage(source: ImageSource.gallery,);
      if (pickedImage != null) {
        imgPath =File(pickedImage.path);
        img.value=imgPath.path.split('/').last;
      } else {
        print('please pick an image');
      }
  }
  createAd()async{
    loading.value = true;
    online.value = await connection();
      if (online.isTrue) {
        String url = "https://glass.teraninjadev.com/api/provider/ads",
            fileName = imgPath.path.split('/').last;
        print(url);
        http.MultipartRequest request =
            http.MultipartRequest("POST", Uri.parse(url));
        request.fields['title'] = adName.text;
        request.fields["price"] = adPrice.text;
        request.headers.addAll({
          "Accept": "application/json",
          "Accept-Language": "en",
          'Authorization': 'Bearer ${userToken.value}'
        });
        var length = await imgPath.length();
        var image = new http.MultipartFile(
            'image', imgPath.readAsBytes().asStream(), length,
            filename: fileName);
        request.files.add(image);
        var response = await http.Response.fromStream(await request.send());
        var data = jsonDecode(response.body);
        print(data);
        if (data['status'] == 1 && data['code'] == 200) {
          loading.value = false;
          Get.back();
          Popup("ستتم مراجعة الاعلان من قبل الادارة قبل نشره");
          resetVals();
          myAds.value=await getMyAds();
          Timer(Duration(seconds: 1), (){
            Get.back();
          });
        } else
          Popup("عفوا لم يتم اضافة الاعلان");
        resetVals();
       }
      else Popup(" يرجي الاتصال بالانترنت واعادة المحاولة");
    loading.value = false;
    }
  getMyAds()async{
    var resultData=[];
    online.value = await connection();
    if(online.isTrue){
      loading.value=true;
      String url="https://glass.teraninjadev.com/api/provider/myAds";
      var response=await http.get(Uri.parse(url),
          headers:{"Accept": "application/json","Accept-Language": "en",
            'Authorization':'Bearer ${userToken.value}'});
      var data=jsonDecode(response.body);
      loading.value=false;
      // print(data);
      var done=(data['status']==1 &&data['code']==200);
      if(done){
        resultData=data['data'];
        myAds.value=resultData;
      }
    }
    loading.value=false;
    return resultData;
  }
  deleteAd(int id)async{
    Get.back();
    online.value = await connection();
    if(online.isTrue){
      loading.value=true;
      Get.back();
      String url="https://glass.teraninjadev.com/api/provider/ads/$id";
      var response=await http.delete(Uri.parse(url),
          headers:{"Accept": "application/json","Accept-Language": "en",
            'Authorization':'Bearer ${userToken.value}'});
      var data=jsonDecode(response.body);
      // print(data);
      var done=(data['status']==1 &&data['code']==200);
      if(done){
        Popup("تم حذف الاعلان");
        myAds.value=await getMyAds();
      }else  Popup("عفوا لم يتم حذف الاعلان");
    }else Popup(" يرجي الاتصال بالانترنت واعادة المحاولة");
    loading.value=false;
    // return ads;
  }
}