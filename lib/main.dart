import 'dart:async';
import 'package:E3yoon/controllers/call_Contrls/share_chat.dart';
import 'package:E3yoon/screens/ads/main_ads.dart';
import 'package:E3yoon/screens/ads/my_ads.dart';
import 'package:E3yoon/screens/ads/new_ad.dart';
import 'package:E3yoon/screens/ads/special_ads.dart';
import 'package:E3yoon/screens/auth/login.dart';
import 'package:E3yoon/screens/auth/new_pass.dart';
import 'package:E3yoon/screens/auth/send_code.dart';
import 'package:E3yoon/screens/auth/send_mail.dart';
import 'package:E3yoon/screens/auth/sign_socail.dart';
import 'package:E3yoon/screens/auth/sign_up.dart';
import 'package:E3yoon/screens/auth/splash1.dart';
import 'package:E3yoon/screens/auth/splash2.dart';
import 'package:E3yoon/screens/main/banners.dart';
import 'package:E3yoon/screens/main/chat.dart';
import 'package:E3yoon/screens/main/chats.dart';
import 'package:E3yoon/screens/main/edit_profile.dart';
import 'package:E3yoon/screens/main/favourite.dart';
import 'package:E3yoon/screens/main/home.dart';
import 'package:E3yoon/screens/main/map.dart';
import 'package:E3yoon/screens/main/orders.dart';
import 'package:E3yoon/screens/main/profile.dart';
import 'package:E3yoon/screens/main/provider_prifile.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'controllers/get_token.dart';
import 'controllers/home_controllers.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // final prefs = await SharedPreferences.getInstance();
  // var loaded=false.obs;
  // print(loaded);
  // Timer(Duration(seconds: 3), (){
  //   loaded.value=true;
  // });
  // print(loaded);
  await getToken();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]);
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'ClassNinja',
    getPages: [
      GetPage(name: "/splash", page: () => Splash()),
      GetPage(name: "/splash2", page: () => Splash2()),
      GetPage(name: "/login", page: () => Login()),
      GetPage(name: "/signup", page: () => SignUp()),
      GetPage(name: "/social", page: () => SignSocial()),
      GetPage(name: "/code", page: () => SendCode()),
      GetPage(name: "/email", page: () => Email()),
      GetPage(name: "/pass", page: () => NewPass()),
      GetPage(name: "/map", page: () => MapScreen()),
      GetPage(name: "/home", page: () => Home()),
      GetPage(name: "/profile", page: () => Profile()),
      GetPage(name: "/ads", page: () => NewAd()),
      GetPage(name: "/fav", page: () => Favourite()),
      GetPage(name: "/orders", page: () => Orders()),
      GetPage(name: "/chats", page: () => Chats()),
      GetPage(name: "/chat", page: () => Chat()),
      GetPage(name: "/myBanners", page: () => Banners()),
      GetPage(name: "/edit", page: () => EditProfile()),
      GetPage(name: "/allAds", page: () => AllAds()),
      GetPage(name: "/myAds", page: () => MyAds()),
      GetPage(name: "/homeAds", page: () => MainAds()),
      // GetPage(name: "/allDocs", page:()=>AllDoctors()),
      GetPage(name: "/details", page: () => Details()),
    ],
    // home: Obx(() => loaded.value?(userToken.isEmpty ? Splash2() : Home()):Splash1()),
    // home:userToken.isNotEmpty?Home():Splash2)(),
    home:Splash(),
  ));
  //import home data
  HomeController homeContrl=Get.put(HomeController());
  await  homeContrl.getData();
  await  chatContrl.getChats();
  // await initApiData();
}
class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);
  @override
  State<Splash> createState() => _SplashState();
}
class _SplashState extends State<Splash> {
  bool load=false;
  // HomeController homeController=Get.put(HomeController());
  @override
  void initState() {
    Timer(Duration(seconds: 4), (){
      setState(() =>load=true);
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return load?(userToken.isEmpty ? Splash2() : Home()):Splash1();
  }
}

//google map android key: AIzaSyAytUmxNs0EEtk4XAWUNgsZXoj1cdAWLIo
//google map ios key: AIzaSyDJsnW3FTmH13CVmRGpuHIj4vnkRqDblS4