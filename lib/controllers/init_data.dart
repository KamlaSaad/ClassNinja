
// import 'package:class_ninja/controllers/fav_controller.dart';
// import 'package:class_ninja/controllers/share_fav.dart';
import 'package:get/get.dart';
import 'ad_controller.dart';
import 'banner_controller.dart';
import 'fav_controller.dart';
import 'get_token.dart';
import 'conn.dart';
initApiData()async{
  bool online = await connection();
  if(online){
    if(userType.value=="provider"){
      print("get provider apis....");
      AdController adContrl=Get.put(AdController());
      BannerController banContrl=Get.put(BannerController());
      adContrl.myAds.value = await adContrl.getMyAds();
      // print(adContrl.myAds.value);
      banContrl.myBanners.value=await banContrl.getBanners();
      print("=====================");
      // print(banContrl.myBanners.value);
    }
    else if(userType.value=="client"){
      print("get client apis...");
      // FavController favController=Get.put(FavController());
      // favController.myFavs.value=await favController.getMyFav();
      // print(favController.myFavs.value);
      // favController.updateIds();
    }
    else {}
  }
}