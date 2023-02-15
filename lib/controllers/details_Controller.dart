import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:io';
import '../widgets/shared.dart';
import 'conn.dart';
import 'location.dart';
class DetailsController extends GetxController{
  LoCation loc=LoCation();
  var data={}.obs,
      ads=[].obs,
      banners=[].obs,
      loading=false.obs,
      online=true.obs,
      latitude=0.0.obs,
      longtude=0.0.obs,
      address1="".obs,
      address2="".obs
  ;
  @override
  void onInit() async{
    online.value = await connection();
    // await loc.getLocation();
    // await loc.goToMaps();
    // TODO: implement onInit
    // super.onInit();
  }

  getData(int id)async{
    print("loading .......");
    loading.value=true;
    String url="https://glass.teraninjadev.com/api/provider/showProvider/$id";
    var response=await http.get(Uri.parse(url),
        headers:{"Accept": "application/json","Accept-Language": "en"});
    var result=jsonDecode(response.body);
    // print(result);
    var done=(result['status']==1 &&result['code']==200);
    if(done){
      data.value=result['data'];
      // await loc.getLocation();
      latitude.value=data['lat']??0.0;
      longtude.value=data['long']??0.0;
      banners.value=data['banners'];
      ads.value=data['ads'];
    }
    loading.value=false;
  }
  goToMap()async{
    if(latitude.value>0){
      Get.toNamed("/map",arguments: [true,latitude.value,longtude.value,(){}]);
      // loc.goToMaps(latitude.value,longtude.value);
    }else Popup("لايمكن الوصول للموقع حاليا");
  }
  Future<void> siteLauncher(String url) async {
    var result=await canLaunchUrl(Uri.parse((url)));
    print(result);
    if (result) {
      await launchUrl(Uri.parse((url)));
    } else  Popup('لايمكن الوصول للرابط الحالي');
  }
  whatsLauncher(String phone){
    String url="";
    if (Platform.isAndroid) {
      url="whatsapp://send?phone=+2" + phone + "&text=";
      // url="https://wa.me/$phone/?text=${Uri.parse('')}"; // new line
    } else {
      // url="https://api.whatsapp.com/send?phone=$phone=${Uri.parse('')}"; // new line
      url="https://wa.me/'+2$phone'?text="; // new line
    }
    siteLauncher(url);
  }
}