import 'dart:convert';
import 'conn.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'fav_controller.dart';
import 'get_token.dart';


class HomeController extends GetxController{
  FavController favController=FavController();
  var shops=[].obs,
      doctors=[].obs,
      loadAgain=false.obs,
      loading=false.obs,
      online=false.obs
  ;
  void onInit() async{
    online.value = await connection();
    if(shops.isEmpty || doctors.isEmpty)
    await  getData();
    // if(doctors.isEmpty)
    //   doctors.value=await getData(2);
    // myAds.value=await getMyAds();
    // TODO: implement onInit
    super.onInit();
  }
  updateItems()async{
    var items=await getData();
    shops.value=items["shop_ads"];
    doctors.value=items["doctorHospital_ads"];
    print(shops.value);
  }
  getData()async{
    Map items={};
    print("loading .......");
    loading.value=true;
    favController.myFavs.value=await favController.getMyFav();
    favController.updateIds();
    // String url=id==1?"https://glass.teraninjadev.com/api/getShopAds":
    // "https://glass.teraninjadev.com/api/getDoctorHospitalAds";
    String url="https://glass.teraninjadev.com/api/Home";
    var response=await http.get(Uri.parse(url),
        headers:{"Accept": "application/json","Accept-Language": "en",
          'Authorization': 'Bearer ${userToken.value}'});
    var data=jsonDecode(response.body);
    print("=================");
    // print(data);
    var done=(data['status']==1 &&data['code']==200);
    if(done){
     items=data['data'];
     shops.value=items["shop_ads"];
     doctors.value=items["doctorHospital_ads"];
    }
    loading.value=false;
    return items;
    // print(items);
    // return items;
  }
}