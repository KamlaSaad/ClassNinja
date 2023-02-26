import 'dart:convert';
import 'package:E3yoon/controllers/call_Contrls/share_chat.dart';
import 'package:E3yoon/controllers/user_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import '../widgets/shared.dart';
import 'ad_controller.dart';
import 'banner_controller.dart';
import 'call_Contrls/share_ads.dart';
import 'call_Contrls/share_banner.dart';
import 'call_Contrls/share_fav.dart';
import 'call_Contrls/share_orders.dart';
import 'conn.dart';
import 'dart:io';
import 'fav_controller.dart';
import 'get_token.dart';
import 'location.dart';
class AuthController extends GetxController{
  UserController userController=Get.put(UserController());
  LoCation loCation=LoCation();
  String validEmail =r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
      validName = r'^[a-z A-Z]+$',
      validPhone = r'(^(?:[+0]9)?[0-9]{10,12}$)',
      imageBaseUrl = "http://success.teraninjadev.com/uploadedimages/";
  var username=TextEditingController(),
      phone=TextEditingController(),
      email=TextEditingController(),
      pass=TextEditingController(),
      pass2=TextEditingController(),
      address="العنوان".obs,
      selectedAdress="".obs,
      email2="".obs,
      img="الشعار".obs,
      imgPath=File("").obs,
      logo="".obs,
      code="".obs,
      token="".obs,
      lat=0.0.obs,
      long=0.0.obs,
      selectedUser="client".obs,
      activity="doctorHospital".obs,
      whatsapp=TextEditingController(),
      site=TextEditingController(),
      snap=TextEditingController(),
      twitter=TextEditingController(),
      face=TextEditingController(),
      instgram=TextEditingController(),
      terms="".obs,
      policy="".obs,
      online=false.obs,
      loading=false.obs,registered=false.obs;

  @override
  void onInit()async {
    await getTerms();
    // TODO: implement onInit
    super.onInit();
  }
  resetSoicals(){
    site.clear();
    snap.clear();
    twitter.clear();
    face.clear();
    instgram.clear();
  }
  resetVals(){
    username.clear();
    email.clear();
    phone.clear();
    whatsapp.clear();
    site.clear();
    pass.clear();
    snap.clear();
    twitter.clear();
    face.clear();
    instgram.clear();
    img.value="الشعار";
    address.value="العنوان";
    selectedAdress.value="";
    logo.value="";
    code.value="";
    token.value="";
  }
  getTerms()async{
    // loading.value=true;
    online.value=await connection();
    if(online.isTrue) {
      String url = "https://glass.teraninjadev.com/api/getPrivacyTerms";
      var response = await http.get(Uri.parse(url),
          headers: {"Accept": "application/json", "Accept-Language": "en"});
      var data = jsonDecode(response.body);
      // print(data);
      if (data['status'] == 1 && data['code'] == 200) {
        terms.value = data['data']['terms'];
        policy.value = data['data']['policy'];
      }
    }
    // loading.value=false;
  }
  uploadImg()async{
    final ImagePicker picker = ImagePicker();
    var pickedImage = await picker.pickImage(source: ImageSource.gallery,);
    if (pickedImage != null) {
      imgPath.value =File(pickedImage.path);
      img.value=imgPath.value.path.split('/').last;
      print("file");
      print(imgPath.value);
    } else {
      print('please pick an image');
    }
  }
  saveLoc()async{
    //24.774265, 46.738586.
    print("============saving location===================");
    if(mapLat>0.0){
      print("====new====");
      long.value=mapLong.value;
      lat.value=mapLat.value;
    }else{
      print("====old====");
      lat.value=loCation.latitude.value;
      long.value=loCation.longitude.value;
    }
    String data = await loCation.getAdress(lat.value, long.value);
    selectedAdress.value=data;
    address.value = data.isNotEmpty?data:"العنوان";
  }
  getLoc()async{
    var result=await loCation.getLocation();
    print("===========result=========");
    return result;
  }
  signUp()async{
    loading.value=true;
    print(selectedUser.value);
    bool online=await connection();
    if (online) {
      String url ="https://glass.teraninjadev.com/api/${selectedUser.value}/register",
          fileName =imgPath.value.path.split('/').last;
      print(url);
      http.MultipartRequest request =http.MultipartRequest("POST", Uri.parse(url));
      request.fields['name']=username.text;
      request.fields["phone"]=phone.text;
      request.fields["email"]=email.text;
      request.fields["whatsapp"]=whatsapp.text;
      if(selectedUser.value=="provider") {
        request.fields["address"] = address.value;
        request.fields["lat"] = "${lat.value}";
        request.fields["long"] = "${long.value}";
      }
      request.fields["password"]=pass.text;
      request.fields["password_confirmation"]=pass.text;
      request.fields["activity"]=activity.value;
      request.fields["activity_id"]="1";
      // request.fields["type"]=activity.value;
      if(face.text.isNotEmpty){
        request.fields["facebook"]=face.text;
      }
      if(site.text.isNotEmpty){
        request.fields["website"]=site.text;
      }
      if(snap.text.isNotEmpty){
        request.fields["snap_chat"]=snap.text;
      }
      if(instgram.text.isNotEmpty){
        request.fields["instagram"]=instgram.text;
      }
      if(twitter.text.isNotEmpty){
        request.fields["twitter"]=twitter.text;
      }
      // request.fields["twitter"]=twitter.text.isEmpty?"":twitter.text;
      if(imgPath.value.path.isNotEmpty) {
        var length = await imgPath.value.length();
        // imgPath.value.lengthSync()
        var img = new http.MultipartFile('image', imgPath.value.readAsBytes().asStream(), length,filename: fileName);
        request.files.add(img);
      }
      // var response=await request.send();
      //   var data=jsonDecode(await response.stream.bytesToString());
      var response = await http.Response.fromStream(await request.send());
      var data=jsonDecode(response.body);
      loading.value=false;
        print(data);
        if (data['status']==1 &&data['code']==200) {
          email2.value=email.text;
          logo.value=data['data']['image']??"";
          Get.offNamed("/code", arguments: ["sign"]);
        }else{
          Popup("عفوا لم يتم تحديث البيانات يرجي التاكد من عدم استخدام بيانات مسجلة من قبل مثل الايميل او الرقم ");
          // loading.value=false;
        }
    }else{Popup(" يرجي الاتصال بالانترنت واعادة المحاولة");}
    loading.value=false;
  }
  login()async{
    // print(selectedUser.value);
    loading.value=true;
    String url="https://glass.teraninjadev.com/api/${selectedUser.value}/login";
    // print(url);
    bool online=await connection();
    if (online) {
      var response=await http.post(Uri.parse(url),
          body: {"phone":phone.text,"password":pass.text},
          headers: {
            "Accept": "application/json",
            "Accept-Language": "en",
          }
      );
      var data=jsonDecode(response.body);
      print(data);
      if (data['status']==1 &&data['code']==200) {
        var userData=data['data']['user'];
        userToken.value=data['data']['token'];
        userType.value=selectedUser.value;
        print("=============${userData['id']}=============");
        await saveToken();
        await userController.saveVals("${userData['id']}",selectedUser.value,data['data']['token'], userData['name'], userData['email'],userData['phone'],
            userData['whatsapp'], userData['address'],userData['lat'],userData['long'], pass.text, userData['image']??"",
            userData['website'],userData['facebook'],userData['twitter'],userData['snap_chat'],userData['instagram']);
        if(userType.value=="client"){
          print("client");
           chatContrl.currentUser.value="${userType.value}${userData['id']}";
           print("firebase id ${chatContrl.currentUser}");
           favController.myFavs.value=await favController.getMyFav();
           ordersController.myOrders.value=await ordersController.getOrders();
           chatContrl.getChats();
        } else {
          print("provider");
           controller.myBanners.value=userData['banners']??[];
           adController.myAds.value=userData['ads']??[];
        }
        loading.value=false;
        Get.offAllNamed("/home");
        resetVals();
        // await initApiData();
      }
      else{
        Popup("عفوا لم يتم الدخول يرجي التاكد من البيانات والمحاولة لاحقا");
        // loading.value=false;
      }
    }else{ Popup(" يرجي الاتصال بالانترنت واعادة المحاولة");}
    loading.value=false;
  }
  verifyEmail()async{
    print("=========================");
    print(email.text);
    print(code.value);
    bool online=await connection();
    if (online)  {
      loading.value=true;
      String url="https://glass.teraninjadev.com/api/${selectedUser.value}/verify/code";
      // print(url);
      var response=await http.post(Uri.parse(url),
          body: {"email":email.text,"code":code.value},
          headers: {"Accept": "application/json","Accept-Language": "en"}
      );
      var data=jsonDecode(response.body);
      print(data);
      if (data['status']==1 &&data['code']==200) {
      await login();
      }else{
        loading.value=false;
        Popup("عفوا تعذر تفعيل الحساب يرجي المحاولة لاحقا");
      }
    }else{ Popup(" يرجي الاتصال بالانترنت واعادة المحاولة");}
  }
  leave(bool logout)async{
    bool online=await connection();
    if (online)  {
    bool done=false;
    String url="https://glass.teraninjadev.com/api/${userController.type.value}/",
    link="logout";
    // print(url+link);
    var head={"Accept": "application/json","Accept-Language": "en",
      'Authorization':'Bearer ${userController.token.value}'};
    var response;
    if(logout==true){
      response=await http.post(Uri.parse(url+link),headers: head);
    }else{
      //remove account
      link="delete/me";
      response=await http.delete(Uri.parse(url+link),headers: head);
    }
    var data=jsonDecode(response.body);
    // print(data);
    done=(data['status']==1 &&data['code']==200);
    if (done) {
      Get.offAllNamed("/splash");
      if(userType.value=="client"){
        Get.delete<FavController>();
      }else{
        Get.delete<BannerController>();
        Get.delete<AdController>();
      }
      selectedUser.value="client";
      userToken.value="";
      userType.value="";
      userController.resetVals();
      myFavIds.clear();
      chatContrl.currentUser.value="";
      chatContrl.userChats.clear();
      chatContrl.allChats.clear();
      ordersController.myOrders.clear();
    }else{ Popup("عفوا لم يتم الطلب يرجي المحاولة لاحقا");}
  }else{Popup(" يرجي الاتصال بالانترنت واعادة المحاولة");}
 }

}