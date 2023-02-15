import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../widgets/shared.dart';
import 'conn.dart';
import 'get_token.dart';

class OrdersController extends GetxController{
  var myOrders=[].obs,
      online =true.obs,
      loading=false.obs;
  // @override
  void onInit() async{
    // loading.value=true;
    online.value = await connection();
    if(myOrders.isEmpty) {
      myOrders.value=await getOrders();
    }
    // TODO: implement onInit
    super.onInit();
  }
  addOrder(int id)async{
    online.value = await connection();
    if (online.isTrue) {
      var response=await http.post(Uri.parse("https://glass.teraninjadev.com/api/client/orders"),
          body: {"ad_id":"$id"},
          headers: {
            "Accept": "application/json",
            "Accept-Language": "en",
            'Authorization': 'Bearer ${userToken.value}'
          }
      );
      var data=jsonDecode(response.body);
      print(data);
      if (data['status'] == 1 && data['code'] == 200) {
        Popup("تم اضافة المنتج");
        myOrders.value=await getOrders();
        // Timer(Duration(seconds: 1), () {
        //   Popup("تم اضافة المنتج");
        // });
        // Get.back();
        // });
      } else Popup("عفوا لم يتم اضافة المنتج");
    }
    else Popup(" يرجي الاتصال بالانترنت واعادة المحاولة");
  }
  getOrders()async{
    var resultData=[];
    loading.value=true;
    online.value = await connection();
    if (online.isTrue) {
      String url="https://glass.teraninjadev.com/api/${userType.value}/orders";
      print(url);
      var response=await http.get(Uri.parse(url),
          headers:{"Accept": "application/json","Accept-Language": "en",
            'Authorization':'Bearer ${userToken.value}'});
      var data=jsonDecode(response.body);
      // print(data);
      var done=(data['status']==1 &&data['code']==200);
      if(done){
        resultData=data['data'];
        myOrders.value=data['data'];
      }
    }
    loading.value=false;
    return resultData;
  }
  bool orderExist(id){
    bool exist=false;
    for(int i=0;i<myOrders.length;i++){
     if(myOrders[i]['ad']['id']==id) {
        exist = true;
      }
    }
    return exist;
  }
}