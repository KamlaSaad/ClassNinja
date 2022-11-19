import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AuthController extends GetxController{
  String validEmail =r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
         validName = r'^[a-z A-Z]+$',
         validPhone = r'(^(?:[+0]9)?[0-9]{10,12}$)',
         imageBaseUrl = "http://success.teraninjadev.com/uploadedimages/";

  var username=TextEditingController(),
      phone=TextEditingController(),
      email=TextEditingController(),
      pass=TextEditingController(),
      pass2=TextEditingController(),
      address=TextEditingController(),
      img=TextEditingController(),
      whatsapp=TextEditingController(),
      site=TextEditingController(),
      snap=TextEditingController(),
      twitter=TextEditingController(),
      face=TextEditingController(),
      instgram=TextEditingController();

  var loading=false.obs;

  void uploadImg(){

  }
}