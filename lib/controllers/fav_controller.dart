import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../widgets/shared.dart';
import 'conn.dart';
import 'get_token.dart';
class FavController extends GetxController{
  // HomeController homeController=HomeController();
  var loading=false.obs,
      online=true.obs,
      // data=[].obs,
      myFavs=[].obs,
      header={"Accept": "application/json","Accept-Language": "en",
     'Authorization':'Bearer ${userToken.value}'};
  @override
  void onInit() async{
    online.value = await connection();
    // if(myFavs.isEmpty) {
    //   myFavs.value=await getMyFav();
    // }
    // myFavs.value=await getMyFav();
    // TODO: implement onInit
    super.onInit();
  }
  getAFav()async{

  }
  addFav(id)async{
    print(userToken.value);
    online.value = await connection();
    print("loading....");
    if(online.isTrue ){
      // loading.value=true;
      String url="https://glass.teraninjadev.com/api/client/favorites";
      var response=await http.post(Uri.parse(url),
          body: {"ad_id":id},headers:{"Accept": "application/json","Accept-Language": "en",
            'Authorization':'Bearer ${userToken.value}'});
      var data=jsonDecode(response.body);
      print(data);
      bool done=(data['status']==1 &&data['code']==200);
      if(done){
        Popup("تم اضافة الاعلان الي المفضلة");
        myFavs.value=await getMyFav();
        updateIds();
        // favIds.value.add(id);
        // await homeController.updateItems();
        Get.toNamed("/fav");
      }
      else{Popup("عفوا لم يتم اضافة الاعلان");}
    }else{Popup("لايوجد اتصال بالانترنت");}
  }
  delFav(id)async{
    loading.value=true;
    online.value = await connection();
    if(online.isTrue){
      String url="https://glass.teraninjadev.com/api/client/favorites/$id";
      var response=await http.delete(Uri.parse(url),
          body: {"ad_id":id},headers:{"Accept": "application/json","Accept-Language": "en",
            'Authorization':'Bearer ${userToken.value}'});
      var data=jsonDecode(response.body);
      print(data);
      bool done=(data['status']==1 &&data['code']==200);
      if(done){
        myFavs.value=await getMyFav();
        updateIds();
        // favIds.value.remove(id);
        Popup("تم حذف الاعلان من المفضلة");
        // homeController.loadAgain.value=true;
      }else{Popup("عفوا لم يتم حذف الاعلان");}
    }else{Popup("لايوجد اتصال بالانترنت");}
    loading.value=false;
  }
  getMyFav()async{
    // print(userToken.value);
    var resultData=[];
    if(userToken.isNotEmpty) {
      print("loading .......");
      loading.value=true;
      online.value = await connection();
      if (online.isTrue) {
        String url = "https://glass.teraninjadev.com/api/client/favorites";
        var response = await http.get(Uri.parse(url), headers:
        {"Accept": "application/json","Accept-Language": "en",'Authorization':'Bearer ${userToken.value}'});
        var result = jsonDecode(response.body);
        // print(result );
        var done = (result['status'] == 1 && result['code'] == 200);
        if (done) {
          loading.value = false;
          resultData= result['data'];
          myFavs.value=result['data'];
          print("fav length ${ myFavs.length}");
          updateIds();
        }
      }
      loading.value = false;
    }
    return resultData;
  }
  updateIds(){
    List favIds=[];
    for(int i=0;i<myFavs.length;i++){
      favIds.add(myFavs[i]['ad']['id']);
    }
    myFavIds.value=favIds;
    print(myFavIds.value);
  }
}
