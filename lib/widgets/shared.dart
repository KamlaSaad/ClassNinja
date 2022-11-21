import 'package:flutter/material.dart';
import 'package:get/get.dart';

double height=Get.height,
       width=Get.width;
Color mainColor=Color(0xff308E7F),
      inputColor=Color(0xffD7EEEA);

Widget Txt(String txt,Color color,double size , FontWeight weight) {
  return Text(
      txt, style: TextStyle(color: color,fontFamily: "Kufam", fontSize: size, fontWeight: weight));
}
Widget underlineTxt(String txt,Color color,double size , FontWeight weight) {
  return Text(
      txt, style: TextStyle(color: color,decoration: TextDecoration.underline,
      fontFamily: "Kufam", fontSize: size, fontWeight: weight));
}
// Widget Btn(String txt,Color color,Color bgColor,Color borderColor,double width,press){
//   return ElevatedButton(
//       style: ButtonStyle(backgroundColor:MaterialStateProperty.all(bgColor),fixedSize: MaterialStateProperty.all(Size(width, 50)),
//           shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//           RoundedRectangleBorder(
//            borderRadius: BorderRadius.circular(10),
//           side: BorderSide(color: bgColor),
//           ),
//       )),
//       onPressed:press,
//       child: Txt(txt, color, 18, FontWeight.w700));
// }
// Widget BorderBtn(String txt,Color color,Color bgColor,Color borderColor,double width,press){
//   return OutlinedButton(
//       style: OutlinedButton.styleFrom(fixedSize:Size(width, 50),
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(10),
//         side: BorderSide(color: bgColor,width: 5),
//       ),
//       ),
//       onPressed:press,
//       child: Txt(txt, color, 18, FontWeight.w700));
// }
Widget Btn(var child,Color color,Color bgColor,Color borderColor,double width,press){
  bool childTxt=child is String;
  return GestureDetector(onTap: press,
      child: Container(width: width,height: 50,
    decoration: BoxDecoration(border:Border.all(color: borderColor,width: 2) ,color: bgColor,
        borderRadius: BorderRadius.circular(10),
    ), child:  Center(child: childTxt?Txt(child, color, 18, FontWeight.bold):child))

  );
}
var FieldBorder=OutlineInputBorder(borderSide: BorderSide(color: inputColor,width: 1),
    borderRadius: BorderRadius.circular(10));

Widget Input(String hint,var contrl,double w,double h, suffix,valid,change){
  return SizedBox(width:w ,height: h,
    child: TextFormField(controller: contrl,decoration: InputDecoration(
      hintText: hint,errorBorder: FieldBorder,errorMaxLines: 1,
      hintStyle: TextStyle(fontWeight: FontWeight.w500,fontFamily:"Kufam",fontSize:18,color: Colors.black),
      fillColor: inputColor,filled: true,
      focusedBorder:FieldBorder,
      border:FieldBorder,enabledBorder: FieldBorder,
      // suffix: suffix,
      suffixIcon: suffix
    ),
      onChanged: change,validator: valid,
    ),
  );
}
Widget InputFile(String hint,double w,double h,tap){
  return GestureDetector(
    child: Container(width: w,height: h,
      padding: EdgeInsets.symmetric(horizontal: 6),
      // alignment: Alignment.centerRight,
      decoration: BoxDecoration(color: inputColor,
        borderRadius: BorderRadius.circular(10)
      ),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(width: w*0.8,height: h,
            child:  SingleChildScrollView(scrollDirection: Axis.horizontal,
                child: Center(child: Txt(hint, Colors.black, 18, FontWeight.w500),)),
          ),
          Icon(Icons.file_upload_outlined,color: mainColor)
        ],
      ),
    ),
    onTap: tap,
  );
}
Widget TxtBtn(String txt,Color color,double size,press){
  return TextButton(
      onPressed: press, child: Txt(txt, color, size, FontWeight.w600));
}
DropDown(){
  // List list=[];
  // return DropdownButton(items:[], onChanged: (val)=>print(val));
  return SizedBox(width:width*0.95 ,height: 50,
    child: DropdownButtonFormField<String>(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        //fillColor: Colors.grey.shade200,
        fillColor:inputColor,
        filled: true,
        hintText:"نوع النشاط",
        hintStyle: TextStyle(fontWeight: FontWeight.w600,fontSize:18),
        focusedBorder:FieldBorder,
        enabledBorder:FieldBorder,
      ),
      icon: Icon(
        Icons.keyboard_arrow_down,
        size: 30,color: mainColor,
      ),
      validator: (value) {
        if (value == null) {
          return 'برجاء الاختيار';
        }
        return null;
      },
      elevation: 1,
      value: "",
      onChanged: (String? newValue) {
        },
      items: [],
    ),
  );
}
Widget errMsg(String error){
  return error.isNotEmpty?Padding(
    padding: const EdgeInsets.only(right: 10),
    child: Txt(error, Colors.red, 16, FontWeight.w500),
  ): SizedBox(height: 0);
}