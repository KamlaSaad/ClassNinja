import 'dart:async';
import 'package:class_ninja/screens/ads/ads.dart';
import 'package:class_ninja/screens/ads/new_ad.dart';
import 'package:class_ninja/screens/ads/all_ads.dart';
import 'package:class_ninja/screens/auth/login.dart';
import 'package:class_ninja/screens/auth/new_pass.dart';
import 'package:class_ninja/screens/auth/send_code.dart';
import 'package:class_ninja/screens/auth/send_mail.dart';
import 'package:class_ninja/screens/auth/sign_socail.dart';
import 'package:class_ninja/screens/auth/sign_up.dart';
import 'package:class_ninja/screens/auth/splash1.dart';
import 'package:class_ninja/screens/auth/splash2.dart';
import 'package:class_ninja/screens/main/details.dart';
import 'package:class_ninja/screens/main/edit_profile.dart';
import 'package:class_ninja/screens/main/favourite.dart';
import 'package:class_ninja/screens/main/home.dart';
import 'package:class_ninja/screens/main/home_ads.dart';
import 'package:class_ninja/screens/main/profile.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'controllers/get_token.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // final prefs = await SharedPreferences.getInstance();
  // var loaded=false.obs;
  // print(loaded);
  // Timer(Duration(seconds: 3), (){
  //   loaded.value=true;
  // });
  // print(loaded);
  await getToken();
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
      GetPage(name: "/home", page: () => Home()),
      GetPage(name: "/profile", page: () => Profile()),
      GetPage(name: "/ads", page: () => NewAd()),
      GetPage(name: "/fav", page: () => Favourite()),
      GetPage(name: "/edit", page: () => EditProfile()),
      GetPage(name: "/allAds", page: () => AllAds()),
      GetPage(name: "/myAds", page: () => MyAds()),
      GetPage(name: "/homeAds", page: () => HomeAds()),
      // GetPage(name: "/allDocs", page:()=>AllDoctors()),
      GetPage(name: "/details", page: () => Details()),
    ],
    // home: Obx(() => loaded.value?(userToken.isEmpty ? Splash2() : Home()):Splash1()),
    // home:userToken.isNotEmpty?Home():Splash2)(),
    home:Splash(),
  ));
}
class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);
  @override
  State<Splash> createState() => _SplashState();
}
class _SplashState extends State<Splash> {
  bool load=false;
  @override
  void initState() {
    Timer(Duration(seconds: 3), (){
      setState(() =>load=true);
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return load?(userToken.isEmpty ? Splash2() : Home()):Splash1();
  }
}
