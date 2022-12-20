import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../widgets/shared.dart';
import 'conn.dart';
import 'get_token.dart';

class BannerController extends GetxController{
  var myBanners=[].obs;
  var imgPath=File("").obs,
      online =true.obs,
      loading=false.obs;
  @override
  void onInit() async{
    online.value = await connection();
    if(myBanners.isEmpty) {
      myBanners.value=await getBanners();
    }
    // TODO: implement onInit
    super.onInit();
  }
  addBanner()async{
    if (online.isTrue) {
      String url = "https://glass.teraninjadev.com/api/provider/banners",
          fileName = imgPath.value.path.split('/').last;
      print(url);
      http.MultipartRequest request =
      http.MultipartRequest("POST", Uri.parse(url));
      request.headers.addAll({
        "Accept": "application/json",
        "Accept-Language": "en",
        'Authorization': 'Bearer ${userToken.value}'
      });
      var length = await imgPath.value.length();
      var image = new http.MultipartFile(
          'image', imgPath.value.readAsBytes().asStream(), length,filename: fileName);
      request.files.add(image);
      var response = await http.Response.fromStream(await request.send());
      var data = jsonDecode(response.body);
      Get.back();
      if (data['status'] == 1 && data['code'] == 200) {
        myBanners.value=await getBanners();
        Timer(Duration(seconds: 1), () {
          Popup("ستتم مراجعة اللافتة من قبل الادارة قبل النشر");
        });
        // Get.back();
        // });
      } else Popup("عفوا لم يتم اضافة اللافتة");
    }
    else Popup(" يرجي الاتصال بالانترنت واعادة المحاولة");
  }
  getBanners()async{
    var resultData=[];
    loading.value=true;
    String url="https://glass.teraninjadev.com/api/provider/myBanners";
    var response=await http.get(Uri.parse(url),
        headers:{"Accept": "application/json","Accept-Language": "en",
          'Authorization':'Bearer ${userToken.value}'});
    var data=jsonDecode(response.body);
    // print(data);
    var done=(data['status']==1 &&data['code']==200);
    if(done){
      resultData=data['data'];
    }
    loading.value=false;
    return resultData;
  }
  deleteBanner(int id)async{
    Get.back();
    if (online.isTrue) {
      loading.value=true;
      String url="https://glass.teraninjadev.com/api/provider/banners/$id";
      var response=await http.delete(Uri.parse(url),
          // body: {"ad_id":id},
          headers:{"Accept": "application/json","Accept-Language": "en",
            'Authorization':'Bearer ${userToken.value}'});
      var data=jsonDecode(response.body);
      // print(data);
      var done=(data['status']==1 &&data['code']==200);
      if(done){
        myBanners.value=await getBanners();
        Popup("تم حذف اللافتة");
      }else  Popup("عفوا لم يتم حذف اللافتة");
      loading.value=false;
    // return ads;
  } else Popup(" يرجي الاتصال بالانترنت واعادة المحاولة");
  }
}