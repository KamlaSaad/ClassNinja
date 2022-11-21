import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

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
      img="الشعار".obs,
      whatsapp=TextEditingController(),
      site=TextEditingController(),
      snap=TextEditingController(),
      twitter=TextEditingController(),
      face=TextEditingController(),
      instgram=TextEditingController();

  var loading=false.obs;

  late File imgPath;
  uploadImg()async{
    final ImagePicker picker = ImagePicker();
    var pickedImage = await picker.pickImage(source: ImageSource.gallery,);
    if (pickedImage != null) {
      imgPath =File(pickedImage.path);
      img.value=imgPath.path.split('/').last;
    } else {
      print('please pick an image');
    }
  }
}