import 'dart:async';

import 'package:class_ninja/screens/auth/login.dart';
import 'package:class_ninja/screens/auth/new_pass.dart';
import 'package:class_ninja/screens/auth/send_code.dart';
import 'package:class_ninja/screens/auth/send_mail.dart';
import 'package:class_ninja/screens/auth/sign_socail.dart';
import 'package:class_ninja/screens/auth/sign_up.dart';
import 'package:class_ninja/screens/auth/splash1.dart';
import 'package:class_ninja/screens/auth/splash2.dart';
import 'package:class_ninja/screens/main/app.dart';
import 'package:class_ninja/screens/main/details.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(debugShowCheckedModeBanner: false,
      title: 'ClassNinja',
      home:Splash(),
        getPages:[
          GetPage(name: "/splash", page:()=>Splash1()),
          GetPage(name: "/splash2", page:()=>Splash2()),
          GetPage(name: "/login", page:()=>Login()),
          GetPage(name: "/signup", page:()=>SignUp()),
          GetPage(name: "/social", page:()=>SignSocial()),
          GetPage(name: "/code", page:()=>SendCode()),
          GetPage(name: "/email", page:()=>Email()),
          GetPage(name: "/pass", page:()=>NewPass()),
          GetPage(name: "/app", page:()=>App()),
          GetPage(name: "/details", page:()=>Details()),
        ]

    );
  }
}

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  bool loading=false;
  @override
  void initState() {
    Timer(Duration(seconds: 5), () {
      setState(() =>loading=true);
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return loading?Splash2():Splash1();
  }
}
